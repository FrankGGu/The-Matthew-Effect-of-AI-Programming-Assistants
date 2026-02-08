-module(throne_inheritance).
-export([new/1, birth/2, death/1, get_inheritance_order/0]).

-record(node, {name, children = []}).

new(king) ->
    register(king, spawn(fun() -> loop(#node{name=king}) end)).

birth(child, parent) ->
    ParentPid = whereis(parent),
    ParentPid ! {birth, child}.

death(king) ->
    KingPid = whereis(king),
    KingPid ! death.

get_inheritance_order() ->
    KingPid = whereis(king),
    KingPid ! get_order,
    receive
        Order -> Order
    end.

loop(Node) ->
    receive
        {birth, Child} ->
            NewChildren = [#node{name=Child} | Node#node.children],
            loop(Node#node{children=NewChildren});
        death ->
            loop(Node#node{children=[]});
        get_order ->
            Order = [Node#node.name | lists:map(fun(N) -> N#node.name end, Node#node.children)],
            Sender = self(),
            lists:foreach(fun(Child) -> 
                ChildPid = whereis(Child#node.name),
                ChildPid ! {get_order, Sender}
            end, Node#node.children),
            receive
                ChildrenOrder -> Sender ! lists:append(Order, ChildrenOrder)
            end,
            loop(Node)
    end.