-spec maximal_rectangle(Matrix :: [[char()]]) -> integer().
maximal_rectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Heights = lists:duplicate(Cols, 0),
            MaxArea = maximal_rectangle(Matrix, Heights, 0, Rows, Cols),
            MaxArea
    end.

maximal_rectangle([], Heights, MaxArea, _Rows, _Cols) -> MaxArea;
maximal_rectangle([Row | Rest], Heights, MaxArea, Rows, Cols) ->
    NewHeights = update_heights(Row, Heights, 0, Cols, []),
    Area = largest_rectangle_area(NewHeights),
    NewMaxArea = max(MaxArea, Area),
    maximal_rectangle(Rest, NewHeights, NewMaxArea, Rows, Cols).

update_heights(_Row, [], _Index, _Cols, Acc) -> lists:reverse(Acc);
update_heights(Row, [H | Heights], Index, Cols, Acc) ->
    case lists:nth(Index + 1, Row) of
        $1 -> NewH = H + 1;
        $0 -> NewH = 0
    end,
    update_heights(Row, Heights, Index + 1, Cols, [NewH | Acc]).

largest_rectangle_area(Heights) ->
    Stack = [],
    MaxArea = 0,
    largest_rectangle_area(Heights, Stack, MaxArea, 0).

largest_rectangle_area([], [], MaxArea, _Index) -> MaxArea;
largest_rectangle_area([], Stack, MaxArea, Index) ->
    {H, I} = hd(Stack),
    NewStack = tl(Stack),
    Width = case NewStack of
                [] -> Index;
                [{_, NewI} | _] -> Index - NewI - 1
            end,
    NewMaxArea = max(MaxArea, H * Width),
    largest_rectangle_area([], NewStack, NewMaxArea, Index);
largest_rectangle_area([H | Heights], Stack, MaxArea, Index) ->
    case Stack of
        [] ->
            NewStack = [{H, Index} | Stack],
            largest_rectangle_area(Heights, NewStack, MaxArea, Index + 1);
        [{TopH, _} | _] when TopH < H ->
            NewStack = [{H, Index} | Stack],
            largest_rectangle_area(Heights, NewStack, MaxArea, Index + 1);
        _ ->
            {TopH, TopI} = hd(Stack),
            NewStack = tl(Stack),
            Width = case NewStack of
                        [] -> Index;
                        [{_, NewI} | _] -> Index - NewI - 1
                    end,
            NewMaxArea = max(MaxArea, TopH * Width),
            largest_rectangle_area([H | Heights], NewStack, NewMaxArea, Index)
    end.