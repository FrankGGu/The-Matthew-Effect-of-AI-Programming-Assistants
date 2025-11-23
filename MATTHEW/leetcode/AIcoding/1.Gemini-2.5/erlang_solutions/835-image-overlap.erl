-module(solution).
-export([max_overlap/2]).

get_val_2d(Arr2D, R, C, N) when R >= 0 and R < N and C >= 0 and C < N ->
    array:get(C, array:get(R, Arr2D));
get_val_2d(_Arr2D, _R, _C, _N) ->
    0.

calculate_current_overlap(Arr1, Arr2, N, Dx, Dy) ->
    lists:sum(
        [ lists:sum(
            [ if Val1 == 1 and Val2 == 1 -> 1; else -> 0 end
              || Y <- lists:seq(0, N-1),
                 Val1 = get_val_2d(Arr1, X, Y, N),
                 X2 = X - Dx,
                 Y2 = Y - Dy,
                 Val2 = get_val_2d(Arr2, X2, Y2, N)
            ]
          )
          || X <- lists:seq(0, N-1)
        ]
    ).

max_overlap(Img1, Img2) ->
    N = length(Img1),
    Arr1 = array:from_list([array:from_list(Row) || Row <- Img1]),
    Arr2 = array:from_list([array:from_list(Row) || Row <- Img2]),

    ShiftRange = lists:seq(-(N-1), N-1),

    lists:foldl(
        fun(Dx, AccMaxDx) ->
            lists:foldl(
                fun(Dy, AccMaxDy) ->
                    Overlap = calculate_current_overlap(Arr1, Arr2, N, Dx, Dy),
                    max(AccMaxDy, Overlap)
                end,
                AccMaxDx,
                ShiftRange
            )
        end,
        0,
        ShiftRange
    ).