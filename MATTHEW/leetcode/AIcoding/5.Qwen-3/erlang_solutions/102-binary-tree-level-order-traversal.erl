-module(btree_level_order).
-export([level_order/1]).

level_order(nil) -> [];
level_order(Root) ->
    Queue = [{Root, 1}],
    traverse(Queue, []).

traverse([], Result) -> lists:reverse(Result);
traverse([{Node, Level} | Rest], Result) ->
    {Val, Left, Right} = Node,
    case lists:keyfind(Level, 1, Result) of
        false ->
            NewResult = [{Level, [Val]} | Result],
            NewQueue = [{Left, Level + 1}, {Right, Level + 1} | Rest],
            traverse(NewQueue, NewResult);
        {Level, List} ->
            NewList = [Val | List],
            NewResult = lists:keyreplace(Level, 1, Result, {Level, NewList}),
            NewQueue = [{Left, Level + 1}, {Right, Level + 1} | Rest],
            traverse(NewQueue, NewResult)
    end.