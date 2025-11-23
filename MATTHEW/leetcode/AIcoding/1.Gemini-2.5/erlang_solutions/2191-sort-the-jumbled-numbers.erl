-module(solution).
-export([sort_jumbled/2]).

jumble_number(0, Mapping) ->
    lists:nth(1, Mapping);

jumble_number(N, Mapping) when N > 0 ->
    Digits = integer_to_list(N),
    JumbledDigitValues = [lists:nth(D - $0 + 1, Mapping) || D <- Digits],
    lists:foldl(fun(DigitValue, Acc) -> Acc * 10 + DigitValue end, 0, JumbledDigitValues).

sort_jumbled(Mapping, Nums) ->
    IndexedNums = lists:zip(Nums, lists:seq(0, length(Nums) - 1)),
    JumbledData = [{jumble_number(N, Mapping), Idx, N} || {N, Idx} <- IndexedNums],
    SortedJumbledData = lists:sort(JumbledData),
    [N || {_, _, N} <- SortedJumbledData].