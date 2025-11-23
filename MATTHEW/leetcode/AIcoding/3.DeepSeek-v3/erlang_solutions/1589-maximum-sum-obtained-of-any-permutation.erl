-module(solution).
-export([max_sum_range_query/2]).

max_sum_range_query(Nums, Requests) ->
    Length = length(Nums),
    Counts = lists:duplicate(Length, 0),
    UpdatedCounts = lists:foldl(fun([Start, End], Acc) ->
                                        increment_range(Acc, Start, End)
                                end, Counts, Requests),
    SortedCounts = lists:sort(fun(A, B) -> A > B end, UpdatedCounts),
    SortedNums = lists:sort(fun(A, B) -> A > B end, Nums),
    lists:foldl(fun({C, N}, Sum) ->
                        (Sum + C * N) rem 1000000007
                end, 0, lists:zip(SortedCounts, SortedNums)).

increment_range(Counts, Start, End) ->
    increment_range(Counts, Start, End, 0).

increment_range([], _, _, _) -> [];
increment_range([H|T], Start, End, Index) ->
    NewH = if Index >= Start, Index =< End -> H + 1; true -> H end,
    [NewH | increment_range(T, Start, End, Index + 1)].