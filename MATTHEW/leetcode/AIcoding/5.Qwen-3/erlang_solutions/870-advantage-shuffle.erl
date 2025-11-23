-module(advantage_shuffle).
-export([advantage_shuffle/2]).

advantage_shuffle(Al, B) ->
    SortedB = lists:sort(B),
    SortedA = lists:sort(Al),
    BIndices = lists:zip(SortedB, lists:seq(0, length(B)-1)),
    {AList, _} = lists:foldl(fun({Val, Index}, {A, BMap}) ->
        case lists:keyfind(Val, 1, BMap) of
            false ->
                {A ++ [Val], BMap};
            {_, BIndex} ->
                {A ++ [Val], lists:keyreplace(Val, 1, BMap, {Val, BIndex})}
        end
    end, {[], BIndices}, SortedA),
    lists:foldl(fun({Val, Index}, Acc) ->
        lists:put(Index, Val, Acc)
    end, lists:seq(0, length(B)-1), AList).