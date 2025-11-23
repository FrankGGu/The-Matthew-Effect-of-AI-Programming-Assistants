-module(maximum_sum_of_an_hourglass).
-export([maxSum/1]).

maxSum(Matrix) ->
    Rows = length(Matrix),
    if
        Rows < 3 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            if
                Cols < 3 -> 0;
                true ->
                    Max = -999999,
                    find_max(Matrix, 0, 0, Cols, Rows, Max)
            end
    end.

find_max(Matrix, R, C, Cols, Rows, Max) ->
    if
        R >= Rows - 2 -> Max;
        true ->
            if
                C >= Cols - 2 -> find_max(Matrix, R + 1, 0, Cols, Rows, Max);
                true ->
                    Sum = get_hourglass_sum(Matrix, R, C),
                    NewMax = max(Max, Sum),
                    find_max(Matrix, R, C + 1, Cols, Rows, NewMax)
            end
    end.

get_hourglass_sum(Matrix, R, C) ->
    A = lists:nth(R + 1, Matrix),
    B = lists:nth(R + 2, Matrix),
    C1 = lists:nth(C + 1, A),
    C2 = lists:nth(C + 2, A),
    C3 = lists:nth(C + 1, B),
    C4 = lists:nth(C + 1, lists:nth(R + 3, Matrix)),
    C5 = lists:nth(C + 2, B),
    C6 = lists:nth(C + 1, lists:nth(R + 1, Matrix)),
    C7 = lists:nth(C + 2, lists:nth(R + 1, Matrix)),
    C1 + C2 + C3 + C4 + C5 + C6 + C7.