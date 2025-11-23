%% -spec generate_matrix(N :: integer()) -> [[integer()]].
generate_matrix(N) ->
    generate_matrix(N, 1, lists:duplicate(N, lists:duplicate(N, 0))).

-spec generate_matrix(N :: integer(), Value :: integer(), Matrix :: [[integer()]]) -> [[integer()]].
generate_matrix(0, _, Matrix) -> Matrix;
generate_matrix(N, Value, Matrix) ->
    generate_matrix(N - 1, Value + 1, update_matrix(N, Value, Matrix)).

-spec update_matrix(N :: integer(), Value :: integer(), Matrix :: [[integer()]]) -> [[integer()]].
update_matrix(_, _, []) -> [];
update_matrix(1, Value, [Row | Rest]) ->
    [[Value | tl(Row)] | Rest];
update_matrix(N, Value, [Row | Rest]) ->
    [Row | update_matrix(N - 1, Value, Rest)].
