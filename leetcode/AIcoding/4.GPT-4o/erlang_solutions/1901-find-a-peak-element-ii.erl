-module(solution).
-export([find_peak_element/1]).

find_peak_element(Matrix) ->
    {Rows, Cols} = lists:tuple_size(Matrix),
    binary_search(Matrix, 0, Rows - 1, Cols).

binary_search(Matrix, Low, High, Cols) when Low =< High ->
    Mid = (Low + High) div 2,
    {MaxVal, MaxCol} = find_max_in_column(Matrix, Mid, Cols),
    case (Mid > 0, Mid < length(Matrix) - 1) of
        {false, _} -> 
            {MaxCol, Mid};
        {_, false} -> 
            {MaxCol, Mid};
        {true, true} ->
            if
                MaxVal > lists:nth(Mid - 1, Matrix) -> 
                    binary_search(Matrix, Low, Mid - 1, Cols);
                MaxVal > lists:nth(Mid + 1, Matrix) -> 
                    binary_search(Matrix, Mid + 1, High, Cols);
                true -> 
                    {MaxCol, Mid}
            end
    end.

find_max_in_column(Matrix, Col, Cols) ->
    lists:foldl(fun(Row, {Max, MaxCol}) ->
        Val = lists:nth(Col, Row),
        if
            Val > Max -> {Val, lists:index(Row, Matrix)};
            true -> {Max, MaxCol}
        end
    end, {0, -1}, Matrix).