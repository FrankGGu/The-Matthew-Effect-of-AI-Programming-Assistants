-module(minimum_cost_to_make_array_equalindromic).
-export([minCost/1]).

minCost(Numbers) ->
    min_cost(Numbers, 1, 1000000000).

min_cost(_, _, 0) -> infinity;
min_cost(Numbers, Start, Length) ->
    case is_palindrome(Start) of
        true ->
            Cost = lists:foldl(fun(N, Acc) -> Acc + abs(N - Start) end, 0, Numbers),
            min(Cost, min_cost(Numbers, Start + 1, Length - 1));
        false ->
            min_cost(Numbers, Start + 1, Length - 1)
    end.

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).