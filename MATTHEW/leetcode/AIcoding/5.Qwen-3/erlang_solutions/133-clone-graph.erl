-module(solution).
-export([clone_graph/1]).

-type node() :: {integer(), list(node())}.

-spec clone_graph(node()) -> node().
clone_graph(undefined) ->
    undefined;
clone_graph(Node) ->
    Map = maps:new(),
    clone(Node, Map).

clone(Node, Map) ->
    case maps:is_key(Node, Map) of
        true ->
            maps:get(Node, Map);
        false ->
            NewNode = {element(1, Node), []},
            maps:put(Node, NewNode, Map),
            lists:foreach(fun(Child) ->
                                ChildClone = clone(Child, Map),
                                NewNode1 = setelement(2, NewNode, [ChildClone | element(2, NewNode)]),
                                ok = erlang:put(NewNode, NewNode1)
                          end, element(2, Node)),
            NewNode
    end.