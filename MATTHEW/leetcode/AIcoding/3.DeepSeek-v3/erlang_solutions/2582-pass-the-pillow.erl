-spec pass_the_pillow(N :: integer(), Time :: integer()) -> integer().
pass_the_pillow(N, Time) ->
    Cycle = (N - 1) * 2,
    Rem = Time rem Cycle,
    if
        Rem < N -> Rem + 1;
        true -> N - (Rem - N + 1)
    end.