-module(solution).
-export([max_length/2]).

max_length(Nums, Limit) ->
    SortedNums = lists:sort(Nums),
    max_length_helper(SortedNums, Limit, 0, 0).

max_length_helper([], _Limit, Count, _Sum) -> 
    Count;
max_length_helper([H | T], Limit, Count, Sum) ->
    NewSum = Sum + H,
    if 
        NewSum =< Limit ->
            max_length_helper(T, Limit, Count + 1, NewSum);
        true ->
            Count
    end.