-spec construct2_d_array(Original :: [integer()], M :: integer(), N :: integer()) -> [[integer()]].
construct2_d_array(Original, M, N) ->
    case length(Original) =:= M * N of
        true ->
            construct2_d_array(Original, M, N, []);
        false ->
            []
    end.

construct2_d_array(_, 0, _, Acc) ->
    lists:reverse(Acc);
construct2_d_array(Original, M, N, Acc) ->
    {Row, Rest} = lists:split(N, Original),
    construct2_d_array(Rest, M - 1, N, [Row | Acc]).