-spec generate(NumRows :: integer()) -> [[integer()]].
generate(NumRows) when NumRows >= 1 ->
    generate_rows(NumRows, [[1]]).

generate_rows(0, Acc) -> lists:reverse(Acc);
generate_rows(N, Acc) ->
    LastRow = hd(Acc),
    NewRow = generate_next_row(LastRow),
    generate_rows(N - 1, [NewRow | Acc]).

generate_next_row([_]) -> [1, 1];
generate_next_row([First | Rest]) ->
    [1 | lists:mapfoldl(fun(X, Y) -> {Y + X, Y + X} end, Rest, [First | Rest])].
