-module(solve).
-export([sum_of_subsequence_widths/1]).

sum_of_subsequence_widths(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Sum = 0,
    Power = 1,
    sum_of_subsequence_widths(Sorted, N, 0, Power, Sum).

sum_of_subsequence_widths(_, 0, _, _, Sum) ->
    Sum;
sum_of_subsequence_widths([H | T], N, I, Power, Sum) ->
    Left = (Power * H) rem 1000000007,
    Right = ((math:pow(2, N - I - 1) * H) rem 1000000007),
    NewSum = (Sum + Left - Right) rem 1000000007,
    sum_of_subsequence_widths(T, N, I + 1, (Power * 2) rem 1000000007, NewSum).