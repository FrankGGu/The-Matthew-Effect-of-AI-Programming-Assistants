-spec unique_paths(M :: integer(), N :: integer()) -> integer().
unique_paths(M, N) ->
    DP = lists:duplicate(M, lists:duplicate(N, 1)),
    unique_paths(DP, 1, 1, M, N).

unique_paths(DP, I, J, M, N) when I =:= M; J =:= N ->
    lists:nth(J, lists:nth(I, DP));
unique_paths(DP, I, J, M, N) ->
    Val = lists:nth(J, lists:nth(I + 1, DP)) + lists:nth(J + 1, lists:nth(I, DP)),
    NewRow = setelement(J, lists:nth(I, DP), Val),
    NewDP = setelement(I, DP, NewRow),
    if
        J + 1 =< N -> unique_paths(NewDP, I, J + 1, M, N);
        I + 1 =< M -> unique_paths(NewDP, I + 1, 1, M, N);
        true -> lists:nth(N, lists:nth(M, NewDP))
    end.