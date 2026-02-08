-module(solution).
-export([sum_digit_differences/1]).

sum_digit_differences(Nums) ->
    N = length(Nums),
    Digits = lists:map(fun(N) -> integer_to_list(N) end, Nums),
    sum_pairs(Digits, 0, 0).

sum_pairs([], _, Acc) ->
    Acc;
sum_pairs([H | T], I, Acc) ->
    sum_pairs(T, I + 1, Acc + sum_diff(H, T, 0)).

sum_diff(_, [], _) ->
    0;
sum_diff(A, [B | T], Pos) ->
    Diff = abs(lists:nth(Pos + 1, A) - lists:nth(Pos + 1, B)),
    sum_diff(A, T, Pos) + Diff.