-module(max_trailing_zeros).
-export([max_trailing_zeros/1]).

max_trailing_zeros(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Prefix2 = create_prefix_sum(Grid, 2, Rows, Cols),
    Prefix5 = create_prefix_sum(Grid, 5, Rows, Cols),
    max_zeros(Grid, Prefix2, Prefix5, Rows, Cols).

grid_size(Grid) ->
    {length(Grid), length(hd(Grid))}.

create_prefix_sum(Grid, Factor, Rows, Cols) ->
    Prefix = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    lists:foldl(
        fun(RowIndex, Acc) ->
            lists:foldl(
                fun(ColIndex, Acc2) ->
                    Val = lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Grid)),
                    Count = count_factors(Val, Factor),
                    Left = case ColIndex of
                        0 -> 0;
                        _ -> lists:nth(ColIndex, lists:nth(RowIndex + 1, Acc))
                    end,
                    Up = case RowIndex of
                        0 -> 0;
                        _ -> lists:nth(ColIndex + 1, lists:nth(RowIndex, Acc))
                    end,
                    UpLeft = case {RowIndex, ColIndex} of
                        {0, _} -> 0;
                        {_, 0} -> 0;
                        _ -> lists:nth(ColIndex, lists:nth(RowIndex, Acc))
                    end,
                    NewVal = Count + Left + Up - UpLeft,
                    lists:nth(RowIndex + 1, Acc2) ! lists:nth(RowIndex + 1, Acc2) ++ [NewVal],
                    Acc2
                end,
                Acc,
                lists:seq(0, Cols - 1)
            )
        end,
        Prefix,
        lists:seq(0, Rows - 1)
    ).

count_factors(Val, Factor) ->
    count_factors(Val, Factor, 0).

count_factors(0, _, Count) ->
    Count;
count_factors(Val, Factor, Count) when Val rem Factor =:= 0 ->
    count_factors(Val div Factor, Factor, Count + 1);
count_factors(_, _, Count) ->
    Count.

max_zeros(Grid, Prefix2, Prefix5, Rows, Cols) ->
    lists:foldl(
        fun(RowIndex, MaxZeros) ->
            lists:foldl(
                fun(ColIndex, MaxZeros2) ->
                    TopLeft = get_value(Prefix2, RowIndex, ColIndex, 2) + get_value(Prefix5, RowIndex, ColIndex, 5),
                    TopRight = get_value(Prefix2, RowIndex, Cols - 1, 2) - get_value(Prefix2, RowIndex, ColIndex, 2) + get_value(Prefix5, RowIndex, Cols - 1, 5) - get_value(Prefix5, RowIndex, ColIndex, 5),
                    BottomLeft = get_value(Prefix2, Rows - 1, ColIndex, 2) - get_value(Prefix2, RowIndex, ColIndex, 2) + get_value(Prefix5, Rows - 1, ColIndex, 5) - get_value(Prefix5, RowIndex, ColIndex, 5),
                    BottomRight = get_value(Prefix2, Rows - 1, Cols - 1, 2) - get_value(Prefix2, RowIndex, Cols - 1, 2) - get_value(Prefix2, Rows - 1, ColIndex, 2) + get_value(Prefix2, RowIndex, ColIndex, 2) + get_value(Prefix5, Rows - 1, Cols - 1, 5) - get_value(Prefix5, RowIndex, Cols - 1, 5) - get_value(Prefix5, Rows - 1, ColIndex, 5) + get_value(Prefix5, RowIndex, ColIndex, 5),

                    Val = lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Grid)),
                    Count2 = count_factors(Val, 2),
                    Count5 = count_factors(Val, 5),

                    UL = min(TopLeft - Count2, TopLeft - Count5),
                    UR = min(TopRight - Count2, TopRight - Count5),
                    BL = min(BottomLeft - Count2, BottomLeft - Count5),
                    BR = min(BottomRight - Count2, BottomRight - Count5),

                    MaxZeros3 = max([MaxZeros2, UL + Count2 + Count5, UR + Count2 + Count5, BL + Count2 + Count5, BR + Count2 + Count5]),
                    MaxZeros3
                end,
                MaxZeros,
                lists:seq(0, Cols - 1)
            )
        end,
        0,
        lists:seq(0, Rows - 1)
    ).

get_value(Prefix, RowIndex, ColIndex, Factor) ->
    case {RowIndex, ColIndex} of
        {_, -1} -> 0;
        {-1, _} -> 0;
        _ ->
            lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, get_prefix_for_factor(Prefix, Factor)))
    end.

get_prefix_for_factor(Prefix, 2) ->
    Prefix;
get_prefix_for_factor(Prefix, 5) ->
    Prefix.