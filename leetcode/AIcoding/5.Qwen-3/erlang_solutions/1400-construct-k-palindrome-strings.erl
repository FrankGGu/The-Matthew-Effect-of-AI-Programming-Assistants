-module(solution).
-export([k_palindrome_strings/2]).

k_palindrome_strings(S, K) ->
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    Values = maps:values(Count),
    OddCount = length([V || V <- Values, V rem 2 == 1]),
    K =< length(S) andalso K >= (if OddCount > 0 -> 1; true -> 0 end).