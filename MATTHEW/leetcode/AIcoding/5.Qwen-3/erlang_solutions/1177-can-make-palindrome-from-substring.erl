-module(solution).
-export([can_make_palindrome/2]).

can_make_palindrome(Queries, S) ->
    Len = length(S),
    Count = lists:seq(0, Len - 1),
    lists:map(fun(Query) -> can_make_palindrome_helper(Query, S) end, Queries).

can_make_palindrome_helper({L, R}, S) ->
    Sub = lists:sublist(S, L + 1, R - L + 1),
    Counts = lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Sub),
    OddCount = dict:fold(fun(_, V, Acc) -> if V rem 2 == 1 -> Acc + 1; true -> Acc end end, 0, Counts),
    OddCount =< 1.