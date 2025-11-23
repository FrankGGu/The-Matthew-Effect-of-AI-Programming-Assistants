-module(jump_game_vi).
-export([maxResult/2]).

maxResult(Nums, K) ->
    maxResult(Nums, K, [0], 0).

maxResult([], _, _, Acc) ->
    Acc;
maxResult(Nums, K, [H|T], Acc) ->
    case Nums of
        [N] ->
            Acc + N;
        [N|Rest] ->
            NewAcc = Acc + N,
            NewQueue = updateQueue(NewAcc, [H|T], K),
            maxResult(Rest, K, NewQueue, NewAcc)
    end.

updateQueue(Val, Queue, K) ->
    {CleanQueue, _} = lists:splitwith(fun(Index) -> Index < -K end, zipWithIndex(Queue)),
    NewCleanQueue = dropSmaller(Val, CleanQueue),
    NewCleanQueue ++ [0].

zipWithIndex(Queue) ->
    zipWithIndex(Queue, 0, []).

zipWithIndex([], _, Acc) ->
    lists:reverse(Acc);
zipWithIndex([H|T], Index, Acc) ->
    zipWithIndex(T, Index - 1, [{Index, H}|Acc]).

dropSmaller(Val, Queue) ->
    dropSmaller(Val, Queue, []).

dropSmaller(Val, [], Acc) ->
    lists:reverse(Acc);
dropSmaller(Val, [{Index, H}|T], Acc) ->
    case H < Val of
        true ->
            dropSmaller(Val, T, Acc);
        false ->
            lists:reverse(Acc) ++ [{Index, H}|T]
    end.