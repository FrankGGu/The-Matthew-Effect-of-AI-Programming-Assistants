-spec update_board(Board :: [[char()]], Click :: [integer()]) -> [[char()]].
update_board(Board, [X, Y]) ->
    case lists:nth(Y + 1, lists:nth(X + 1, Board)) of
        $M ->
            set_elem(Board, X, Y, $X);
        $E ->
            reveal(Board, X, Y);
        _ ->
            Board
    end.

reveal(Board, X, Y) ->
    case count_mines(Board, X, Y) of
        0 ->
            NewBoard = set_elem(Board, X, Y, $B),
            lists:foldl(fun({DX, DY}, Acc) ->
                case {X + DX, Y + DY} of
                    {NX, NY} when NX >= 0, NY >= 0, NX < length(Board), NY < length(hd(Board)) ->
                        case lists:nth(NY + 1, lists:nth(NX + 1, Acc)) of
                            $E -> reveal(Acc, NX, NY);
                            _ -> Acc
                        end;
                    _ -> Acc
                end
            end, NewBoard, [{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}]);
        N ->
            set_elem(Board, X, Y, $0 + N)
    end.

count_mines(Board, X, Y) ->
    lists:foldl(fun({DX, DY}, Acc) ->
        case {X + DX, Y + DY} of
            {NX, NY} when NX >= 0, NY >= 0, NX < length(Board), NY < length(hd(Board)) ->
                case lists:nth(NY + 1, lists:nth(NX + 1, Board)) of
                    $M -> Acc + 1;
                    _ -> Acc
                end;
            _ -> Acc
        end
    end, 0, [{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}]).

set_elem(Board, X, Y, Val) ->
    Row = lists:nth(X + 1, Board),
    NewRow = set_nth(Y + 1, Row, Val),
    set_nth(X + 1, Board, NewRow).

set_nth(1, [_|T], Val) -> [Val|T];
set_nth(N, [H|T], Val) -> [H|set_nth(N - 1, T, Val)].