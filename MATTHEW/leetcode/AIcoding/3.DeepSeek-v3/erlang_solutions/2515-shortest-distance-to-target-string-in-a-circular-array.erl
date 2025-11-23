-spec shortest_distance(Words :: [unicode:unicode_binary()], Target :: unicode:unicode_binary(), StartIndex :: integer()) -> integer().
shortest_distance(Words, Target, StartIndex) ->
    N = length(Words),
    MinDistance = lists:min([
        min(abs(StartIndex - I), N - abs(StartIndex - I)) ||
        I <- lists:seq(0, N - 1),
        lists:nth(I + 1, Words) =:= Target
    ]),
    case MinDistance of
        infinity -> -1;
        _ -> MinDistance
    end.