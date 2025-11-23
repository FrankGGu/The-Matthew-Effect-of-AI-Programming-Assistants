-module(solution).
-export([max_value_sum/1]).

max_value_sum(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Max = -1,
    {Max1, _} = find_max(Board, Rows, Cols, Max),
    Max1.

find_max(Board, Rows, Cols, Max) ->
    lists:foldl(
        fun(R, {CurrentMax, Acc}) ->
            lists:foldl(
                fun(C, {InnerMax, InnerAcc}) ->
                    case get_cell(Board, R, C) of
                        undefined -> {InnerMax, InnerAcc};
                        V1 ->
                            lists:foldl(
                                fun(R2, {InnerMax2, InnerAcc2}) ->
                                    lists:foldl(
                                        fun(C2, {InnerMax3, InnerAcc3}) ->
                                            case (R2 /= R orelse C2 /= C) of
                                                true ->
                                                    case get_cell(Board, R2, C2) of
                                                        undefined -> {InnerMax3, InnerAcc3};
                                                        V2 ->
                                                            lists:foldl(
                                                                fun(R3, {InnerMax4, InnerAcc4}) ->
                                                                    lists:foldl(
                                                                        fun(C3, {InnerMax5, InnerAcc5}) ->
                                                                            case (R3 /= R orelse C3 /= C) andalso (R3 /= R2 orelse C3 /= C2) of
                                                                                true ->
                                                                                    case get_cell(Board, R3, C3) of
                                                                                        undefined -> {InnerMax5, InnerAcc5};
                                                                                        V3 ->
                                                                                            Sum = V1 + V2 + V3,
                                                                                            case Sum > InnerMax5 of
                                                                                                true -> {Sum, InnerAcc5};
                                                                                                false -> {InnerMax5, InnerAcc5}
                                                                                            end
                                                                                    end;
                                                                                false -> {InnerMax5, InnerAcc5}
                                                                            end
                                                                        end,
                                                                        {InnerMax4, InnerAcc4},
                                                                        lists:seq(0, Cols - 1)
                                                                    )
                                                                end,
                                                                {InnerMax3, InnerAcc3},
                                                                lists:seq(0, Rows - 1)
                                                            )
                                                    end;
                                                false -> {InnerMax3, InnerAcc3}
                                            end
                                        end,
                                        {InnerMax2, InnerAcc2},
                                        lists:seq(0, Cols - 1)
                                    )
                                end,
                                {InnerMax, InnerAcc},
                                lists:seq(0, Rows - 1)
                    end
                end,
                {CurrentMax, Acc},
                lists:seq(0, Cols - 1)
            )
        end,
        {Max, []},
        lists:seq(0, Rows - 1)
    ).

get_cell(Board, R, C) ->
    Row = lists:nth(R + 1, Board),
    lists:nth(C + 1, Row).