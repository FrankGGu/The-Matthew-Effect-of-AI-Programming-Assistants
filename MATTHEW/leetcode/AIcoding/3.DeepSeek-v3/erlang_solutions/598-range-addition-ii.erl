-spec max_count(M :: integer(), N :: integer(), Ops :: [[integer()]]) -> integer().
max_count(M, N, Ops) ->
    case Ops of
        [] ->
            M * N;
        _ ->
            MinA = lists:min([A || [A, _] <- Ops]),
            MinB = lists:min([B || [_, B] <- Ops]),
            MinA * MinB
    end.