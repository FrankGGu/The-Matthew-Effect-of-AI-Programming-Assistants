-module(maximal_rectangle).
-export([maximalRectangle/1]).

maximalRectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        _ -> maximalRectangleHelper(Matrix, 0)
    end.

maximalRectangleHelper(Matrix, MaxArea) ->
    {Rows, Cols} = matrix_size(Matrix),
    case Rows of
        0 -> MaxArea;
        _ ->
            Heights = lists:foldl(
                fun(Row, Acc) ->
                    case Acc of
                        [] -> [row_to_heights(Row)];
                        [PrevHeights | _] ->
                            [lists:zipwith(
                                fun(H, V) ->
                                    case V of
                                        "1" -> H + 1;
                                        "0" -> 0
                                    end
                                , PrevHeights, Row) | Acc]
                    end
                end, [], Matrix),

            NewMaxArea = lists:max([largestRectangleArea(H) || H <- Heights]),
            maximalRectangleHelper([], max(MaxArea, NewMaxArea))
    end.

row_to_heights(Row) ->
    [case V of
        "1" -> 1;
        "0" -> 0
    end || V <- Row].

matrix_size(Matrix) ->
    case Matrix of
        [] -> {0, 0};
        [Row | _] -> {length(Matrix), length(Row)}
    end.

largestRectangleArea(Heights) ->
    largestRectangleAreaHelper(Heights, [], 0).

largestRectangleAreaHelper([], _, MaxArea) ->
    MaxArea;
largestRectangleAreaHelper([H | Rest], Stack, MaxArea) ->
    largestRectangleAreaHelper(Rest, process_height(H, Stack, MaxArea), MaxArea).

process_height(H, Stack, MaxArea) ->
    case Stack of
        [] ->
            [{H, 0}];
        [{PrevH, PrevIndex} | _] when H > PrevH ->
            [{H, length(Stack)} | Stack];
        _ ->
            {NewStack, NewMaxArea} = pop_and_calculate(H, Stack, MaxArea, length(Stack)),
            case NewStack of
                [] ->
                    [{H, 0}];
                [{PrevH, PrevIndex} | _] when H > PrevH ->
                    [{H, PrevIndex + 1} | NewStack];
                _ ->
                    [{H, 0}] ++ NewStack
            end,
            finish_calculation(H, NewStack, NewMaxArea)
    end.

pop_and_calculate(H, Stack, MaxArea, Index) ->
    case Stack of
        [] ->
            {[], MaxArea};
        [{PrevH, PrevIndex} | Rest] when PrevH > H ->
            NewArea = PrevH * (Index - PrevIndex),
            pop_and_calculate(H, Rest, max(MaxArea, NewArea), PrevIndex);
        _ ->
            {Stack, MaxArea}
    end.

finish_calculation(H, Stack, MaxArea) ->
    finish_calculation_helper(Stack, MaxArea, length(Stack)).

finish_calculation_helper([], MaxArea, Index) ->
    MaxArea;
finish_calculation_helper([{PrevH, PrevIndex} | Rest], MaxArea, Index) ->
    NewArea = PrevH * (Index - PrevIndex),
    finish_calculation_helper(Rest, max(MaxArea, NewArea), PrevIndex).

largestRectangleAreaHelper_wrapper(Heights) ->
    NewHeights = Heights ++ [0],
    largestRectangleAreaHelper(NewHeights, [], 0).

largestRectangleArea(Heights) ->
    largestRectangleAreaHelper_wrapper(Heights).