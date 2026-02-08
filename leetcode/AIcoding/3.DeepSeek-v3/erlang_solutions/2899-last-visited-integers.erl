-spec last_visited_integers(Words :: [unicode:unicode_binary()]) -> [integer()].
last_visited_integers(Words) ->
    {Result, _, _} = lists:foldl(fun
        (<<"prev">>, {Res, Prev, Seen}) ->
            case Seen of
                [] -> {Res ++ [-1], Prev, Seen};
                _ -> {Res ++ [lists:nth(Prev, Seen)], Prev + 1, Seen}
            end;
        (Word, {Res, _, Seen}) ->
            Num = binary_to_integer(Word),
            {Res, 1, [Num | Seen]}
    end, {[], 1, []}, Words),
    Result.