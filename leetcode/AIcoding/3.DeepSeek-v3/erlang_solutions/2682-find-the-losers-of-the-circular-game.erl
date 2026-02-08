-spec circular_game_losers(N :: integer(), K :: integer()) -> [integer()].
circular_game_losers(N, K) ->
    Visited = array:new(N, {default, false}),
    {Losers, _} = play(1, K, N, Visited, 0, []),
    Losers.

play(Current, K, N, Visited, Steps, Losers) ->
    case array:get(Current - 1, Visited) of
        true ->
            {lists:sort(Losers), Visited};
        false ->
            NewVisited = array:set(Current - 1, true, Visited),
            Next = (Current + Steps * K) rem N,
            Next1 = if Next == 0 -> N; true -> Next end,
            play(Next1, K, N, NewVisited, Steps + 1, [Current | Losers])
    end.