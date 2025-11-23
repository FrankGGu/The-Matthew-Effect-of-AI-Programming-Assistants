-spec max_covered_rows(Matrix :: [[integer()]], NumSelect :: integer()) -> integer().
max_covered_rows(Matrix, NumSelect) ->
    Cols = length(hd(Matrix)),
    MaxCovered = 0,
    Combinations = combinations(lists:seq(0, Cols - 1), NumSelect),
    lists:foldl(fun(ColsSelected, Acc) ->
        Covered = count_covered_rows(Matrix, ColsSelected),
        max(Acc, Covered)
    end, MaxCovered, Combinations).

combinations(List, K) ->
    case K of
        0 -> [[]];
        _ when K > length(List) -> [];
        _ ->
            [[H | T] || H <- List, T <- combinations(lists:sublist(List, H + 1, length(List)), K - 1)]
    end.

count_covered_rows(Matrix, ColsSelected) ->
    lists:foldl(fun(Row, Acc) ->
        case is_row_covered(Row, ColsSelected) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Matrix).

is_row_covered(Row, ColsSelected) ->
    lists:all(fun(Col) -> lists:nth(Col + 1, Row) =:= 1 end, ColsSelected).