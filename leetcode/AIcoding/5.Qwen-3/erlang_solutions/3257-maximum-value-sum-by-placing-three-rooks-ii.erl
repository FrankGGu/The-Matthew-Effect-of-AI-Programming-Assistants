-module(max_value_sum_by_placing_three_rooks_ii).
-export([maxRookSum/1]).

maxRookSum(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Max = -infinity,
    lists:foldl(fun(RowIndex, Acc) ->
        lists:foldl(fun(ColIndex, Acc2) ->
            Value = lists:nth(RowIndex + 1, Board) -- [ColIndex],
            if
                Value == [] -> Acc2;
                true ->
                    lists:foldl(fun(RowIndex2, Acc3) ->
                        if
                            RowIndex2 == RowIndex -> Acc3;
                            true ->
                                lists:foldl(fun(ColIndex2, Acc4) ->
                                    if
                                        ColIndex2 == ColIndex -> Acc4;
                                        true ->
                                            NewValue = lists:nth(RowIndex2 + 1, Board) -- [ColIndex2],
                                            if
                                                NewValue == [] -> Acc4;
                                                true ->
                                                    lists:foldl(fun(RowIndex3, Acc5) ->
                                                        if
                                                            RowIndex3 == RowIndex; RowIndex3 == RowIndex2 -> Acc5;
                                                            true ->
                                                                lists:foldl(fun(ColIndex3, Acc6) ->
                                                                    if
                                                                        ColIndex3 == ColIndex; ColIndex3 == ColIndex2 -> Acc6;
                                                                        true ->
                                                                            Sum = lists:nth(RowIndex + 1, Board) -- [ColIndex] ++ lists:nth(RowIndex2 + 1, Board) -- [ColIndex2] ++ lists:nth(RowIndex3 + 1, Board) -- [ColIndex3],
                                                                            case lists:sum(Sum) > Acc6 of
                                                                                true -> lists:sum(Sum);
                                                                                false -> Acc6
                                                                            end
                                                                    end
                                                                end, Acc4, lists:seq(0, Cols - 1))
                                                    end
                                                end
                                            end
                                        end
                                    end, Acc3, lists:seq(0, Cols - 1))
                                end
                            end
                        end, Acc2, lists:seq(0, Rows - 1))
                    end, Max, lists:seq(0, Cols - 1))
    end, Max, lists:seq(0, Rows - 1)).

lists:nth(Index, List) when is_list(List) ->
    lists:nth(Index + 1, List).

lists:nth(Index, List) when is_integer(Index), is_list(List) ->
    lists:nth(Index + 1, List).

lists:foldl(Fun, Acc, List) when is_function(Fun, 2), is_list(List) ->
    lists:foldl(Fun, Acc, List).

lists:seq(Start, End) when Start =< End ->
    lists:seq(Start, End).