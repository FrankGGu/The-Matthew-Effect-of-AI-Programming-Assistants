-module(solution).
-export([maxSideLength/2]).

maxSideLength(Mat, Threshold) ->
    M = length(Mat),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Mat)),
            case N of
                0 -> 0;
                _ ->
                    PS = build_prefix_sum(Mat, M, N),

                    MinDim = min(M, N),

                    binary_search_k(0, MinDim, M, N, PS, Threshold)
            end
    end.

build_prefix_sum(Mat, M, N) ->
    InitialPS_rows = array:new([{size, M + 1}, {default, undefined}]),
    PS_with_zero_rows = array:map(fun(_) -> array:new([{size, N + 1}, {default, 0}]) end, InitialPS_rows),

    lists:foldl(
        fun(R_idx, AccPS_rows_array) ->
            Mat_row = lists:nth(R_idx + 1, Mat),

            CurrentPS_row_array = array:get(R_idx + 1, AccPS_rows_array),

            NewCurrentPS_row_array = lists:foldl(
                fun(C_idx, AccPS_cols_array) ->
                    Val = lists:nth(C_idx + 1, Mat_row),

                    PrevRowPS_currCol = array:get(C_idx + 1, array:get(R_idx, AccPS_rows_array)),
                    CurrRowPS_prevCol = array:get(C_idx, AccPS_cols_array),
                    PrevRowPS_prevCol = array:get(C_idx, array:get(R_idx, AccPS_rows_array)),

                    NewVal = Val + PrevRowPS_currCol + CurrRowPS_prevCol - PrevRowPS_prevCol,

                    array:set(C_idx + 1, NewVal, AccPS_cols_array)
                end,
                CurrentPS_row_array,
                lists:seq(0, N - 1)
            ),

            array:set(R_idx + 1, NewCurrentPS_row_array, AccPS_rows_array)
        end,
        PS_with_zero_rows,
        lists:seq(0, M - 1)
    ).

get_square_sum(R, C, K, PS_array) ->
    PS_RK_CK = array:get(C + K, array:get(R + K, PS_array)),
    PS_R_CK = array:get(C + K, array:get(R, PS_array)),
    PS_RK_C = array:get(C, array:get(R + K, PS_array)),
    PS_R_C = array:get(C, array:get(R, PS_array)),

    PS_RK_CK - PS_R_CK - PS_RK_C + PS_R_C.

check(K, M, N, PS, Threshold) ->
    case K of
        0 -> true;
        _ ->
            check_rows(0, M - K, K, N - K, PS, Threshold)
    end.

check_rows(R, MaxR, K, MaxC, PS, Threshold) ->
    case R > MaxR of
        true -> false;
        false ->
            case check_cols(R, 0, MaxC, K, PS, Threshold) of
                true -> true;
                false -> check_rows(R + 1, MaxR, K, MaxC, PS, Threshold)
            end
    end.

check_cols(R, C, MaxC, K, PS, Threshold) ->
    case C > MaxC of
        true -> false;
        false ->
            SquareSum = get_square_sum(R, C, K, PS),
            case SquareSum =< Threshold of
                true -> true;
                false -> check_cols(R, C + 1, MaxC, K, PS, Threshold)
            end
    end.

binary_search_k(Low, High, M, N, PS, Threshold) ->
    case Low > High of
        true -> Low - 1;
        false ->
            Mid = Low + (High - Low) div 2,
            case Mid == 0 of
                true -> binary_search_k(Mid + 1, High, M, N, PS, Threshold);
                false ->
                    case check(Mid, M, N, PS, Threshold) of
                        true -> binary_search_k(Mid + 1, High, M, N, PS, Threshold);
                        false -> binary_search_k(Low, Mid - 1, M, N, PS, Threshold)
                    end
            end
    end.