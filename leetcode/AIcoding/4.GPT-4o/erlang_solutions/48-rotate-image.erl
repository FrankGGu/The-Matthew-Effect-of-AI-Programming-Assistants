%% Rotate the matrix 90 degrees clockwise in-place.
%% -record(matrix, {matrix = [] :: list(list(integer()))}).

-spec rotate(matrix :: #matrix{}) -> #matrix{}.
rotate(#matrix{matrix = Matrix}) ->
    rotate_in_place(Matrix, length(Matrix)).

rotate_in_place(Matrix, N) when N > 0 ->
    NewMatrix = lists:map(fun(Row) -> lists:reverse(Row) end, Matrix),
    transpose(NewMatrix, N, []).

transpose([], _, Acc) -> Acc;
transpose([Row | Rest], N, Acc) ->
    TransposedRow = transpose_row(Row, N, []),
    transpose(Rest, N, [TransposedRow | Acc]).

transpose_row([], _, Acc) -> Acc;
transpose_row([Head | Tail], N, Acc) ->
    transpose_row(Tail, N - 1, [Head | Acc]).
