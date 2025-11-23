-module(solution).
-export([ways/3]).

ways(Pizza, K) ->
    Rows = length(Pizza),
    Cols = length(hd(Pizza)),
    Prefix = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, 0)),
    Prefix1 = init_prefix(Pizza, Prefix, 1, 1, Rows, Cols),
    DP = ets:new(dp, [set, private]),
    ets:insert(DP, {{Rows, Cols, 0}, 1}),
    Ans = dfs(DP, Prefix1, 1, 1, K - 1, Rows, Cols),
    ets:delete(DP),
    Ans rem 1000000007.

init_prefix(_, Prefix, I, J, Rows, Cols) when I > Rows ->
    Prefix;
init_prefix(Pizza, Prefix, I, J, Rows, Cols) when J > Cols ->
    init_prefix(Pizza, Prefix, I + 1, 1, Rows, Cols);
init_prefix(Pizza, Prefix, I, J, Rows, Cols) ->
    Row = lists:nth(I, Pizza),
    Cell = lists:nth(J, Row),
    Val = if Cell == $A -> 1; true -> 0 end,
    PrevRow = lists:nth(I - 1, Prefix),
    PrevCol = lists:nth(J - 1, lists:nth(I, Prefix)),
    PrevBoth = lists:nth(J - 1, lists:nth(I - 1, Prefix)),
    Current = lists:nth(J, lists:nth(I, Prefix)),
    NewVal = Val + lists:nth(J, PrevRow) + Current - PrevBoth,
    NewRow = set_nth(J, lists:nth(I, Prefix), NewVal),
    NewPrefix = set_nth(I, Prefix, NewRow),
    init_prefix(Pizza, NewPrefix, I, J + 1, Rows, Cols).

dfs(DP, Prefix, I, J, K, Rows, Cols) ->
    case ets:lookup(DP, {I, J, K}) of
        [{{_, _, _}, Val}] -> Val;
        [] ->
            case K of
                0 ->
                    case has_apple(Prefix, I, J, Rows, Cols) of
                        true -> 1;
                        false -> 0
                    end;
                _ ->
                    Res = lists:foldl(fun(Cut, Acc) ->
                        case Cut of
                            {row, R} ->
                                case has_apple(Prefix, I, J, R, Cols) of
                                    true ->
                                        Val = dfs(DP, Prefix, R + 1, J, K - 1, Rows, Cols),
                                        (Acc + Val) rem 1000000007;
                                    false -> Acc
                                end;
                            {col, C} ->
                                case has_apple(Prefix, I, J, Rows, C) of
                                    true ->
                                        Val = dfs(DP, Prefix, I, C + 1, K - 1, Rows, Cols),
                                        (Acc + Val) rem 1000000007;
                                    false -> Acc
                                end
                        end
                    end, 0, get_cuts(I, J, Rows, Cols)),
                    ets:insert(DP, {{I, J, K}, Res}),
                    Res
            end
    end.

has_apple(Prefix, I, J, R, C) ->
    Total = lists:nth(C, lists:nth(R, Prefix)),
    Left = lists:nth(J - 1, lists:nth(R, Prefix)),
    Top = lists:nth(C, lists:nth(I - 1, Prefix)),
    Corner = lists:nth(J - 1, lists:nth(I - 1, Prefix)),
    (Total - Left - Top + Corner) > 0.

get_cuts(I, J, Rows, Cols) ->
    RowCuts = [{row, R} || R <- lists:seq(I, Rows - 1)],
    ColCuts = [{col, C} || C <- lists:seq(J, Cols - 1)],
    RowCuts ++ ColCuts.

set_nth(1, [_|T], X) -> [X|T];
set_nth(N, [H|T], X) -> [H|set_nth(N-1, T, X)].