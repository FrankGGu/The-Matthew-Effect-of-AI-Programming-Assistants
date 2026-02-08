-module(maximal_rectangle).
-export([maximal_rectangle/1]).

maximal_rectangle(Matrix) ->
    Max = 0,
    Rows = length(Matrix),
    if
        Rows == 0 -> Max;
        true ->
            Cols = length(hd(Matrix)),
            Heights = lists:duplicate(Cols, 0),
            MaxArea = 0,
            loop_rows(Matrix, 0, Heights, MaxArea)
    end.

loop_rows(_, _, _, MaxArea) when MaxArea == 0 -> MaxArea;
loop_rows(Matrix, Row, Heights, MaxArea) ->
    case Row < length(Matrix) of
        true ->
            CurrentRow = lists:nth(Row + 1, Matrix),
            update_heights(CurrentRow, Heights),
            NewMaxArea = largest_rectangle_area(Heights),
            loop_rows(Matrix, Row + 1, Heights, max(MaxArea, NewMaxArea));
        false ->
            MaxArea
    end.

update_heights([], _) -> ok;
update_heights([H | T], [Ht | Tt]) ->
    case H of
        $0 -> update_heights(T, [0 | Tt]);
        _ -> update_heights(T, [Ht + 1 | Tt])
    end.

largest_rectangle_area(Heights) ->
    Stack = [],
    Area = 0,
    Index = 0,
    largest_rectangle_area(Heights, Stack, Area, Index).

largest_rectangle_area(_, _, MaxArea, _) when MaxArea == 0 -> MaxArea;
largest_rectangle_area(Heights, Stack, MaxArea, Index) ->
    case Index < length(Heights) of
        true ->
            case Stack == [] orelse lists:nth(Index + 1, Heights) >= lists:last(Stack) of
                true ->
                    largest_rectangle_area(Heights, [Index | Stack], MaxArea, Index + 1);
                false ->
                    Top = lists:last(Stack),
                    NewStack = lists:sublist(Stack, length(Stack) - 1),
                    Height = lists:nth(Top + 1, Heights),
                    Width = if
                                NewStack == [] -> Index;
                                true -> Index - lists:last(NewStack) - 1
                            end,
                    NewArea = max(MaxArea, Height * Width),
                    largest_rectangle_area(Heights, NewStack, NewArea, Index)
            end;
        false ->
            MaxArea
    end.