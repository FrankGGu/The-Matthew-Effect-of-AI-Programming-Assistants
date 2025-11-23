-module(max_rectangle).
-export([maximal_rectangle/1]).

maximal_rectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Heights = lists:duplicate(Cols, 0),
            MaxArea = 0,
            loop_rows(0, Rows, Cols, Matrix, Heights, MaxArea)
    end.

loop_rows(Row, Rows, Cols, Matrix, Heights, MaxArea) when Row < Rows ->
    update_heights(Row, Cols, Matrix, Heights),
    Area = largest_rectangle_area(Heights),
    NewMax = max(MaxArea, Area),
    loop_rows(Row + 1, Rows, Cols, Matrix, Heights, NewMax);
loop_rows(_, _, _, _, _, MaxArea) ->
    MaxArea.

update_heights(Row, Cols, Matrix, Heights) ->
    lists:foreach(fun(Col) ->
        case lists:nth(Col + 1, lists:nth(Row, Matrix)) of
            $0 -> lists:replace(Col, 0, Heights);
            _ -> lists:replace(Col, lists:nth(Col + 1, Heights) + 1, Heights)
        end
    end, lists:seq(0, Cols - 1)).

largest_rectangle_area(Heights) ->
    Stack = [],
    MaxArea = 0,
    loop_heights(0, Heights, Stack, MaxArea).

loop_heights(Index, Heights, Stack, MaxArea) when Index < length(Heights) ->
    case Stack of
        [] -> loop_heights(Index + 1, Heights, [Index], MaxArea);
        [Top | _] when Top >= Index -> 
            {H, NewStack} = pop(Stack, Index, Heights),
            Area = H * (if NewStack == [] -> Index; true -> Index - hd(NewStack) - 1 end),
            loop_heights(Index, Heights, NewStack, max(MaxArea, Area));
        _ -> loop_heights(Index + 1, Heights, [Index | Stack], MaxArea)
    end;
loop_heights(_, _, Stack, MaxArea) ->
    loop_remaining(Stack, Heights, MaxArea).

pop([], _, _) -> {0, []};
pop([Top | Rest], Index, Heights) ->
    H = lists:nth(Top + 1, Heights),
    if H > lists:nth(Index + 1, Heights) -> {H, Rest}; true -> {0, [Top | Rest]} end.

loop_remaining([], _, MaxArea) -> MaxArea;
loop_remaining([Top | Rest], Heights, MaxArea) ->
    H = lists:nth(Top + 1, Heights),
    Width = if Rest == [] -> length(Heights); true -> length(Heights) - hd(Rest) - 1 end,
    Area = H * Width,
    loop_remaining(Rest, Heights, max(MaxArea, Area)).