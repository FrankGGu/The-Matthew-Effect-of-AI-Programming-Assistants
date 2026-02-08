-module(btree_level_order_traversal_ii).
-export([level_order/1]).

level_order(undefined) -> [];
level_order(Root) ->
    traverse([Root], []).

traverse([], Acc) ->
    lists:reverse(Acc);
traverse(Level, Acc) ->
    NextLevel = [],
    CurrentLevel = [],
    [Val | _] = Level,
    CurrentLevel = [Val],
    lists:foreach(fun(Node) ->
        if Node =:= undefined -> ok;
           true -> 
               NextLevel = lists:append(NextLevel, [Node#btree.left, Node#btree.right])
        end
    end, Level),
    traverse(NextLevel, [CurrentLevel | Acc]).

-record(btree, {val, left, right}).