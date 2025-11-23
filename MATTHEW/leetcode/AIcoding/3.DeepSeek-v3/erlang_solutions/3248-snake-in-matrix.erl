-spec find_snake(matrix()) -> [integer()].
find_snake(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            find_path(Matrix, 0, 0, Rows, Cols, [], right)
    end.

find_path(Matrix, Row, Col, Rows, Cols, Path, Dir) ->
    if
        Row >= Rows orelse Col >= Cols orelse Row < 0 orelse Col < 0 -> [];
        true ->
            Value = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
            case lists:member(Value, Path) of
                true -> [];
                false ->
                    NewPath = Path ++ [Value],
                    case is_snake(NewPath) of
                        true ->
                            case Dir of
                                right ->
                                    Right = find_path(Matrix, Row, Col + 1, Rows, Cols, NewPath, right),
                                    Down = find_path(Matrix, Row + 1, Col, Rows, Cols, NewPath, down),
                                    case {Right, Down} of
                                        {[], []} -> NewPath;
                                        {[], _} -> Down;
                                        {_, []} -> Right;
                                        {_, _} ->
                                            if
                                                length(Right) > length(Down) -> Right;
                                                true -> Down
                                            end
                                    end;
                                down ->
                                    Down = find_path(Matrix, Row + 1, Col, Rows, Cols, NewPath, down),
                                    Left = find_path(Matrix, Row, Col - 1, Rows, Cols, NewPath, left),
                                    case {Down, Left} of
                                        {[], []} -> NewPath;
                                        {[], _} -> Left;
                                        {_, []} -> Down;
                                        {_, _} ->
                                            if
                                                length(Down) > length(Left) -> Down;
                                                true -> Left
                                            end
                                    end;
                                left ->
                                    Left = find_path(Matrix, Row, Col - 1, Rows, Cols, NewPath, left),
                                    Up = find_path(Matrix, Row - 1, Col, Rows, Cols, NewPath, up),
                                    case {Left, Up} of
                                        {[], []} -> NewPath;
                                        {[], _} -> Up;
                                        {_, []} -> Left;
                                        {_, _} ->
                                            if
                                                length(Left) > length(Up) -> Left;
                                                true -> Up
                                            end
                                    end;
                                up ->
                                    Up = find_path(Matrix, Row - 1, Col, Rows, Cols, NewPath, up),
                                    Right = find_path(Matrix, Row, Col + 1, Rows, Cols, NewPath, right),
                                    case {Up, Right} of
                                        {[], []} -> NewPath;
                                        {[], _} -> Right;
                                        {_, []} -> Up;
                                        {_, _} ->
                                            if
                                                length(Up) > length(Right) -> Up;
                                                true -> Right
                                            end
                                    end
                            end;
                        false -> []
                    end
            end
    end.

is_snake([_]) -> true;
is_snake([A, B | Rest]) ->
    case abs(A - B) of
        1 -> is_snake([B | Rest]);
        _ -> false
    end.