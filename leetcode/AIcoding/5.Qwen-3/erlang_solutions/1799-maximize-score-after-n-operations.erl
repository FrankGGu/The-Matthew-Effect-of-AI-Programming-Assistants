-module(solution).
-export([max_score/1]).

max_score(Numbers) ->
    lists:foldl(fun(_I, Acc) -> max_score_helper(Numbers, Acc, 0) end, 0, lists:seq(1, length(Numbers) div 2)).

max_score_helper(Numbers, Score, Index) when Index >= length(Numbers) - 1 ->
    Score;
max_score_helper(Numbers, Score, Index) ->
    {Gcd, Remaining} = find_gcd_and_remove(Index, Numbers),
    max_score_helper(Remaining, Score + Gcd, Index + 1).

find_gcd_and_remove(I, List) ->
    Lists = lists:split(I, List),
    First = lists:nth(I + 1, List),
    Second = lists:nth(I + 2, List),
    Gcd = gcd(First, Second),
    Remaining = lists:append(lists:nth(1, Lists), lists:nthtail(I + 2, List)),
    {Gcd, Remaining}.

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).