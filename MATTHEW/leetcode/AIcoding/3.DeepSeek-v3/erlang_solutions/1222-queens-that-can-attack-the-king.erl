-spec queens_attackthe_king(Queens :: [[integer()]], King :: [integer()]) -> [[integer()]].
queens_attackthe_king(Queens, King) ->
    QueensSet = sets:from_list(Queens),
    [KX, KY] = King,
    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
    lists:foldl(fun({DX, DY}, Acc) -> 
        find_queen_in_direction(KX, KY, DX, DY, QueensSet, Acc)
    end, [], Directions).

find_queen_in_direction(X, Y, DX, DY, QueensSet, Acc) ->
    NX = X + DX,
    NY = Y + DY,
    case (NX >= 0) and (NX < 8) and (NY >= 0) and (NY < 8) of
        true ->
            case sets:is_element([NX, NY], QueensSet) of
                true -> [[NX, NY] | Acc];
                false -> find_queen_in_direction(NX, NY, DX, DY, QueensSet, Acc)
            end;
        false -> Acc
    end.