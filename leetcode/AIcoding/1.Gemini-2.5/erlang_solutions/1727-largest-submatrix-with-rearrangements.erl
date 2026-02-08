-module(solution).
-export([largest_submatrix/1]).

largest_submatrix(Matrix) ->
    R = length(Matrix),
    C = length(hd(Matrix)),
    InitialHeights = lists:duplicate(C, 0),
    {MaxArea, _FinalHeights} = lists:foldl(
        fun(Row, {AccMaxArea, PrevHeights}) ->
            % Calculate new heights for the current row
            NewHeights = lists:zipwith(
                fun(Cell, H) ->
                    if Cell == 1 -> H + 1;
                       true -> 0
                    end
                end,
                Row,
                PrevHeights
            ),

            % Sort heights in descending order
            SortedHeights = lists:sort(fun(A, B) -> A >= B end, NewHeights),

            % Calculate the maximum area for the current row
            % by iterating through sorted heights and considering each as the smallest height
            % for a rectangle of increasing width.
            CurrentRowMaxArea = lists:foldl(
                fun({H, Idx}, RowAccMax) ->
                    Area = H * (Idx + 1), % Height * Width (Idx + 1 because Idx is 0-based)
                    max(RowAccMax, Area)
                end,
                0,
                lists:zip(SortedHeights, lists:seq(0, C - 1))
            ),

            % Update overall max area and pass new heights for the next row
            {max(AccMaxArea, CurrentRowMaxArea), NewHeights}
        end,
        {0, InitialHeights},
        Matrix
    ),
    MaxArea.