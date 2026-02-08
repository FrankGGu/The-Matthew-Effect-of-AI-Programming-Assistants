-spec min_domino_rotations(Tops :: [integer()], Bottoms :: [integer()]) -> integer().
min_domino_rotations(Tops, Bottoms) ->
    Candidates = [hd(Tops), hd(Bottoms)],
    lists:min(
        lists:filtermap(
            fun(Candidate) ->
                case check_rotations(Tops, Bottoms, Candidate) of
                    {ok, Rotations} -> {true, Rotations};
                    error -> false
                end
            end,
            Candidates
        ) ++ [infinity]
    ).

check_rotations(Tops, Bottoms, Candidate) ->
    {RotationsTop, RotationsBottom} = lists:foldl(
        fun({Top, Bottom}, {RT, RB}) ->
            if
                Top =:= Candidate, Bottom =:= Candidate -> {RT, RB};
                Top =:= Candidate -> {RT, RB + 1};
                Bottom =:= Candidate -> {RT + 1, RB};
                true -> {infinity, infinity}
            end
        end,
        {0, 0},
        lists:zip(Tops, Bottoms)
    ),
    MinRotations = min(RotationsTop, RotationsBottom),
    if
        MinRotations =/= infinity -> {ok, MinRotations};
        true -> error
    end.