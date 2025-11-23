-spec num_of_ways(N :: integer()) -> integer().
num_of_ways(N) ->
    Mod = 1000000007,
    if
        N == 0 -> 0;
        N == 1 -> 12;
        true ->
            {A, B} = lists:foldl(fun(_, {PrevA, PrevB}) ->
                NewA = (PrevA * 3 + PrevB * 2) rem Mod,
                NewB = (PrevA * 2 + PrevB * 2) rem Mod,
                {NewA, NewB}
            end, {6, 6}, lists:seq(2, N)),
            (A + B) rem Mod
    end.