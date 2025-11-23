-module(maximal_rectangle).
-export([maximalRectangle/1]).

maximalRectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        [Row|_] ->
            Cols = length(Row),
            InitialHeights = lists:duplicate(Cols, 0),
            element(2, lists:foldl(
                fun(CurrentRow, {AccHeights, AccMaxArea}) ->
                    NewHeights = update_heights(CurrentRow, AccHeights),
                    RowMaxArea = largest_rectangle_in_histogram(NewHeights),
                    {NewHeights, max(AccMaxArea, RowMaxArea)}
                end,
                {InitialHeights, 0},
                Matrix
            ))
    end.

update_heights(Row, PrevHeights) ->
    lists:zipwith(
        fun(Char, PrevHeight) ->
            case Char of
                $1 -> PrevHeight + 1;
                $0 -> 0
            end
        end,
        Row,
        PrevHeights
    ).

largest_rectangle_in_histogram(Heights) ->
    lrih_loop_internal(Heights ++ [0], 0, [], 0).

lrih_loop_internal(HeightsList, CurrentIndex, Stack, MaxArea) ->
    case {HeightsList, Stack} of
        {[], []} -> MaxArea;
        {[], [{StackH, StackIdx}|RestStack]} ->
            Width = case RestStack of
                        [] -> CurrentIndex;
                        [{_, NextStackIdx}|_] -> CurrentIndex - NextStackIdx - 1
                    end,
            CurrentRectArea = StackH * Width,
            NewMaxArea = max(MaxArea, CurrentRectArea),
            lrih_loop_internal([], CurrentIndex, RestStack, NewMaxArea);
        {[H|T], _} ->
            case Stack of
                [] ->
                    lrih_loop_internal(T, CurrentIndex + 1, [{H, CurrentIndex}], MaxArea);
                [{StackH, StackIdx}|_] when H >= StackH ->
                    lrih_loop_internal(T, CurrentIndex + 1, [{H, CurrentIndex}|Stack], MaxArea);
                [{StackH, StackIdx}|RestStack] ->
                    Width = case RestStack of
                                [] -> CurrentIndex;
                                [{_, NextStackIdx}|_] -> CurrentIndex - NextStackIdx - 1
                            end,
                    CurrentRectArea = StackH * Width,
                    NewMaxArea = max(MaxArea, CurrentRectArea),
                    lrih_loop_internal([H|T], CurrentIndex, RestStack, NewMaxArea)
            end
    end.