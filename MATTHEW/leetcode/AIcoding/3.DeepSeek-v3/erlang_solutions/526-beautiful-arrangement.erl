-spec count_arrangement(N :: integer()) -> integer().
count_arrangement(N) ->
    Used = lists:duplicate(N + 1, false),
    count(1, N, Used).

count(Pos, N, Used) when Pos > N ->
    1;
count(Pos, N, Used) ->
    lists:foldl(fun(I, Acc) ->
        case (not lists:nth(I, Used)) and ((I rem Pos =:= 0) or (Pos rem I =:= 0)) of
            true ->
                NewUsed = setelement(I, Used, true),
                Acc + count(Pos + 1, N, NewUsed);
            false ->
                Acc
        end
    end, 0, lists:seq(1, N)).