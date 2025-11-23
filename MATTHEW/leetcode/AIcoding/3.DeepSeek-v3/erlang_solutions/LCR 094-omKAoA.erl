-module(solution).
-export([min_cut/1]).

min_cut(S) ->
    N = length(S),
    DP = lists:duplicate(N + 1, -1),
    IsPal = lists:duplicate(N, lists:duplicate(N, false)),
    {DP1, IsPal1} = preprocess(S, DP, IsPal, N),
    solve(S, DP1, IsPal1, 0, N).

preprocess(S, DP, IsPal, N) ->
    {DP1, IsPal1} = lists:foldl(fun(I, {DPAcc, IsPalAcc}) ->
        lists:foldl(fun(J, {DPAcc1, IsPalAcc1}) ->
            case J == 1 orelse (lists:nth(I - J + 1, S) == lists:nth(I, S) andalso lists:nth(I - J + 2, lists:nth(I - 1, IsPalAcc1)) of
                true ->
                    IsPalAcc2 = set_pal(IsPalAcc1, I - J + 1, I, true),
                    {DPAcc1, IsPalAcc2};
                false ->
                    {DPAcc1, IsPalAcc1}
            end
        end, {DPAcc, IsPalAcc}, lists:seq(1, I))
    end, {DP, IsPal}, lists:seq(1, N)),
    {DP1, IsPal1}.

set_pal(IsPal, I, J, Val) ->
    Row = lists:nth(I, IsPal),
    NewRow = lists:sublist(Row, J - 1) ++ [Val] ++ lists:nthtail(J, Row),
    lists:sublist(IsPal, I - 1) ++ [NewRow] ++ lists:nthtail(I, IsPal).

solve(S, DP, IsPal, I, N) ->
    case I == N of
        true -> 0;
        false ->
            case lists:nth(I + 1, DP) /= -1 of
                true -> lists:nth(I + 1, DP);
                false ->
                    Min = lists:foldl(fun(J, Acc) ->
                        case lists:nth(I + 1, lists:nth(J + 1, IsPal)) of
                            true ->
                                min(Acc, solve(S, DP, IsPal, J, N) + 1);
                            false ->
                                Acc
                        end
                    end, 999999, lists:seq(I, N - 1)),
                    NewDP = lists:sublist(DP, I) ++ [Min] ++ lists:nthtail(I + 1, DP),
                    solve(S, NewDP, IsPal, I + 1, N)
            end
    end.