-module(count_palindromic_subsequences).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
    N = length(S),
    Mod = 1000000007,
    S_list = string:to_list(S),

    {DP, Left, Right} = solve(S_list, N, Mod, []),

    lists:nth(1, lists:nth(1, DP)).

solve(S_list, N, Mod, Memo) ->
    solve(S_list, 0, N - 1, N, Mod, Memo).

solve(S_list, I, J, N, Mod, Memo) ->
    case lists:keyfind({I, J}, 1, Memo) of
        false ->
            case I > J of
                true ->
                    {[{ {I, J}, 0 }], [], []};
                false ->
                    case I == J of
                        true ->
                            {[{ {I, J}, 1 }], [], []};
                        false ->
                            First = lists:nth(I+1, S_list),
                            Last = lists:nth(J+1, S_list),
                            case First == Last of
                                true ->
                                    {DP_inner, Left, Right} = solve(S_list, I + 1, J - 1, N, Mod, Memo),
                                    case find_left_right(S_list, I + 1, J - 1, First) of
                                        {NoLeft, NoRight} ->
                                            case NoLeft > NoRight of
                                                true ->
                                                    {DP_inner_inner, _, _} = solve(S_list, J, J, N, Mod, Memo),
                                                    {DP_inner_inner2, _, _} = solve(S_list, J+1, J+1, N, Mod, Memo),

                                                    DP = [{ {I, J}, (2 * lists:nth(1, lists:nth(1, DP_inner))) - lists:nth(1, lists:nth(1, DP_inner_inner)) rem Mod + Mod rem Mod }];
                                                false ->
                                                    case NoLeft < NoRight of
                                                        true ->
                                                            {DP_inner_inner, _, _} = solve(S_list, I, I, N, Mod, Memo),
                                                            {DP_inner_inner2, _, _} = solve(S_list, I-1, I-1, N, Mod, Memo),
                                                            DP = [{ {I, J}, (2 * lists:nth(1, lists:nth(1, DP_inner))) - lists:nth(1, lists:nth(1, DP_inner_inner)) rem Mod + Mod rem Mod }];
                                                        false ->
                                                            {DP_inner_inner, _, _} = solve(S_list, NoLeft+1, NoRight-1, N, Mod, Memo),
                                                            DP = [{ {I, J}, (2 * lists:nth(1, lists:nth(1, DP_inner))) + 2 rem Mod - lists:nth(1, lists:nth(1, DP_inner_inner)) rem Mod + Mod rem Mod }];
                                                    end
                                            end;
                                false ->
                                    {DP_inner1, _, _} = solve(S_list, I + 1, J, N, Mod, Memo),
                                    {DP_inner2, _, _} = solve(S_list, I, J - 1, N, Mod, Memo),
                                    {DP_inner3, _, _} = solve(S_list, I + 1, J - 1, N, Mod, Memo),

                                    DP = [{ {I, J}, (lists:nth(1, lists:nth(1, DP_inner1)) + lists:nth(1, lists:nth(1, DP_inner2)) - lists:nth(1, lists:nth(1, DP_inner3))) rem Mod + Mod rem Mod }];
                            end,
                            {DP, [], []};
                    end
            end;
        {_, Val} ->
            {[{ {I, J}, Val }], [], []}
    end.

find_left_right(S_list, I, J, C) ->
    find_left(S_list, I, J, C, 0, 0).

find_left(S_list, I, J, C, NoLeft, NoRight) ->
    case I > J of
        true ->
            {NoLeft, NoRight};
        false ->
            case lists:nth(I+1, S_list) == C of
                true ->
                    find_right(S_list, I, J, C, I, NoRight);
                false ->
                    find_left(S_list, I + 1, J, C, NoLeft, NoRight)
            end
    end.

find_right(S_list, I, J, C, NoLeft, NoRight) ->
    case I > J of
        true ->
            {NoLeft, NoRight};
        false ->
            case lists:nth(J+1, S_list) == C of
                true ->
                    {NoLeft, J};
                false ->
                    find_right(S_list, I, J - 1, C, NoLeft, NoRight)
            end
    end.