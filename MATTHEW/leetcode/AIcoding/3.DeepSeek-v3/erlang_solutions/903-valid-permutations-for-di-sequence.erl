-module(solution).
-export([num_perms_di_sequence/1]).

num_perms_di_sequence(S) ->
    N = length(S),
    DP = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, N),
    DP2 = solve(S, DP1, N),
    lists:nth(1, lists:nth(N + 1, DP2)).

init_dp(DP, N) ->
    lists:foldl(fun(I, Acc) ->
                    Row = lists:nth(I, Acc),
                    NewRow = setnth(1, I, 1, Row),
                    setnth(I, NewRow, Acc)
                end, DP, lists:seq(1, N + 1)).

solve(S, DP, N) ->
    lists:foldl(fun(I, Acc) ->
                    lists:foldl(fun(J, DPAcc) ->
                                    case lists:nth(I, S) of
                                        $D -> update_dp(I, J, DPAcc, N, fun lists:sum/1, fun lists:nthtail/2);
                                        $I -> update_dp(I, J, DPAcc, N, fun lists:sum/1, fun lists:sublist/2)
                                    end
                                end, Acc, lists:seq(1, N - I + 2))
                end, DP, lists:seq(1, N)).

update_dp(I, J, DP, N, SumFun, SubFun) ->
    Row = lists:nth(I + 1, DP),
    SubList = SubFun(lists:nth(I, DP), J),
    Sum = SumFun(SubList),
    NewRow = setnth(J, Sum, Row),
    setnth(I + 1, NewRow, DP).

setnth(1, X, [H|T]) -> [X|T];
setnth(N, X, [H|T]) -> [H|setnth(N - 1, X, T)].