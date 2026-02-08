-spec most_visited(N :: integer(), Rounds :: [integer()]) -> [integer()].
most_visited(N, Rounds) ->
    Start = hd(Rounds),
    End = lists:last(Rounds),
    if
        Start =< End -> lists:seq(Start, End);
        true -> lists:seq(1, End) ++ lists:seq(Start, N)
    end.