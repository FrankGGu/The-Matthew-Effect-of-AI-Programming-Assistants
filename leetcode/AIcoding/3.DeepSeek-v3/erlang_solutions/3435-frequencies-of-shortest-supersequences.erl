-module(solution).
-export([shortest_supersequence/2]).

shortest_supersequence(A, B) ->
    M = length(A),
    N = length(B),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, M, N),
    DP2 = fill_dp(DP1, A, B, M, N),
    {Len, Freq} = DP2,
    Freq.

init_dp(DP, M, N) ->
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case I =:= 0 orelse J =:= 0 of
                true -> 
                    case I =:= 0 andalso J =:= 0 of
                        true -> [{0, 1} | Acc1];
                        false when I =:= 0 -> [{J, 1} | Acc1];
                        false -> [{I, 1} | Acc1]
                    end;
                false -> [{0, 0} | Acc1]
            end
        end, [], lists:seq(0, N)) | Acc
    end, [], lists:seq(0, M)).

fill_dp(DP, A, B, M, N) ->
    lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            case I =:= 0 orelse J =:= 0 of
                true -> AccJ;
                false ->
                    AChar = lists:nth(I, A),
                    BChar = lists:nth(J, B),
                    case AChar =:= BChar of
                        true ->
                            Prev = lists:nth(I - 1, lists:nth(J - 1, DP)),
                            {Len, Freq} = Prev,
                            NewEntry = {Len + 1, Freq},
                            set_dp(AccJ, I, J, NewEntry);
                        false ->
                            Up = lists:nth(I - 1, lists:nth(J, DP)),
                            Left = lists:nth(I, lists:nth(J - 1, DP)),
                            case compare(Up, Left) of
                                gt -> set_dp(AccJ, I, J, Up);
                                lt -> set_dp(AccJ, I, J, Left);
                                eq -> 
                                    {LenU, FreqU} = Up,
                                    {LenL, FreqL} = Left,
                                    NewEntry = {LenU, FreqU + FreqL},
                                    set_dp(AccJ, I, J, NewEntry)
                            end
                    end
            end
        end, AccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)).

compare({Len1, _}, {Len2, _}) when Len1 > Len2 -> gt;
compare({Len1, _}, {Len2, _}) when Len1 < Len2 -> lt;
compare(_, _) -> eq.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I, DP),
    NewRow = lists:sublist(Row, J - 1) ++ [Val] ++ lists:nthtail(J, Row),
    lists:sublist(DP, I - 1) ++ [NewRow] ++ lists:nthtail(I, DP).