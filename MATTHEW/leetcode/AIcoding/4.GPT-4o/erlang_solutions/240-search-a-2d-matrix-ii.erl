%% Definition for 2D matrix search
%% -record(matrix, {matrix :: list(list(integer()))}).

-spec search_matrix(Matrix :: #matrix{}, Target :: integer()) -> boolean().
search_matrix(#matrix{matrix = Matrix}, Target) ->
    search_matrix(Matrix, Target, 0, length(Matrix) - 1).

search_matrix(_, _, _, -1) -> false;
search_matrix([], _, _, _) -> false;
search_matrix([Row | Rest], Target, RowStart, RowEnd) when RowStart <= RowEnd ->
    search_row(Row, Target) orelse
    search_matrix(Rest, Target, RowStart + 1, RowEnd).

search_row([], _) -> false;
search_row([Head | Tail], Target) when Head =:= Target -> true;
search_row([Head | Tail], Target) when Head > Target -> false;
search_row([Head | Tail], Target) -> search_row(Tail, Target).
