-module(solution).
-export([sum_imbalance/1]).

sum_imbalance(Nums) ->
    sum_imbalance(Nums, 0, 0).

sum_imbalance([], _, Sum) ->
    Sum;
sum_imbalance([H | T], Index, Sum) ->
    Subarray = lists:sublist(Nums, Index + 1),
    Imbalance = imbalance(Subarray),
    sum_imbalance(T, Index + 1, Sum + Imbalance).

imbalance([]) ->
    0;
imbalance([X]) ->
    0;
imbalance(List) ->
    Sorted = lists:sort(List),
    Max = lists:last(Sorted),
    Min = lists:nth(1, Sorted),
    Max - Min.

lists:sublist(List, N) when is_list(List), is_integer(N) ->
    lists:sublist(List, N).