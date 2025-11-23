-module(solution).
-export([max_side/2]).

max_side(Matrix, Threshold) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxSide = 0,
    {MaxSide, _} = lists:foldl(fun(I, {CurrentMax, _}) ->
        lists:foldl(fun(J, {CurrentMax, _}) ->
            if
                I == 0 orelse J == 0 ->
                    CurrentMax;
                true ->
                    Size = min(I, J) + 1,
                    Sum = get_square_sum(Matrix, I, J, Size),
                    if
                        Sum =< Threshold ->
                            {Size, Sum};
                        true ->
                            {CurrentMax, Sum}
                    end
            end
        end, {CurrentMax, 0}, lists:seq(0, Cols - 1))
    end, {0, 0}, lists:seq(0, Rows - 1)).

get_square_sum(Matrix, I, J, Size) ->
    Total = 0,
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            Acc2 + element(I - X + 1, element(J - Y + 1, Matrix))
        end, Acc, lists:seq(0, Size - 1))
    end, Total, lists:seq(0, Size - 1)).