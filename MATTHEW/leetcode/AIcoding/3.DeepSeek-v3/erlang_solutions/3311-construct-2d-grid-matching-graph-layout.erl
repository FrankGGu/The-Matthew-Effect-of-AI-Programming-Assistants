-spec construct2DArray(Original :: [integer()], M :: integer(), N :: integer()) -> [[integer()]].
construct2DArray(Original, M, N) ->
    case length(Original) =:= M * N of
        true ->
            construct(Original, N, []);
        false ->
            []
    end.

construct([], _, Acc) ->
    lists:reverse(Acc);
construct(Original, N, Acc) ->
    {Row, Rest} = lists:split(N, Original),
    construct(Rest, N, [Row | Acc]).