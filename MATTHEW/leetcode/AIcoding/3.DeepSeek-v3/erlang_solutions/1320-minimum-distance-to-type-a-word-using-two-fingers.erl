-module(solution).
-export([minimum_distance/1]).

minimum_distance(Word) ->
    N = length(Word),
    DP = lists:duplicate(27, lists:duplicate(27, 0)),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            lists:foldl(fun(K, Acc3) ->
                update_dp(Word, I, J, K, Acc3)
            end, Acc2, lists:seq(0, 25))
        end, Acc, lists:seq(0, 25))
    end, DP, lists:seq(1, N)).

update_dp(Word, I, J, K, DP) ->
    C = lists:nth(I, Word) - $A,
    if
        J == C ->
            lists:foldl(fun(L, Acc) ->
                Cost = cost(K, C),
                Min = min(lists:nth(K + 1, lists:nth(L + 1, Acc)) + Cost, lists:nth(L + 1, lists:nth(K + 1, Acc))),
                set_dp(Acc, K + 1, L + 1, Min)
            end, DP, lists:seq(0, 25));
        K == C ->
            lists:foldl(fun(L, Acc) ->
                Cost = cost(J, C),
                Min = min(lists:nth(L + 1, lists:nth(J + 1, Acc)) + Cost, lists:nth(J + 1, lists:nth(L + 1, Acc))),
                set_dp(Acc, L + 1, J + 1, Min)
            end, DP, lists:seq(0, 25));
        true ->
            DP
    end.

cost(A, B) ->
    if
        A == 26 -> 0;
        true ->
            X1 = A div 6,
            Y1 = A rem 6,
            X2 = B div 6,
            Y2 = B rem 6,
            abs(X1 - X2) + abs(Y1 - Y2)
    end.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I, DP),
    NewRow = set_nth(J, Val, Row),
    set_nth(I, NewRow, DP).

set_nth(1, Val, [_|T]) -> [Val|T];
set_nth(N, Val, [H|T]) -> [H|set_nth(N - 1, Val, T)].