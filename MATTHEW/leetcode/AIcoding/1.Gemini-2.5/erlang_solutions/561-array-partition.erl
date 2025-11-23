-module(solution).
-export([array_partition/1]).

array_partition(Nums) ->
    SortedNums = lists:sort(Nums),
    sum_min_pairs(SortedNums, 0, 0).

sum_min_pairs([], _Index, Sum) ->
    Sum;
sum_min_pairs([H | T], Index, CurrentSum) ->
    if
        Index rem 2 == 0 ->
            sum_min_pairs(T, Index + 1, CurrentSum + H);
        true ->
            sum_min_pairs(T, Index + 1, CurrentSum)
    end.