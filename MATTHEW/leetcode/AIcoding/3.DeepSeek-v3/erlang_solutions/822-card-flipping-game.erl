-spec flipgame(Fronts :: [integer()], Backs :: [integer()]) -> integer().
flipgame(Fronts, Backs) ->
    Same = sets:from_list([F || {F, B} <- lists:zip(Fronts, Backs), F == B]),
    AllNumbers = sets:from_list(Fronts ++ Backs),
    Candidates = sets:subtract(AllNumbers, Same),
    case sets:size(Candidates) of
        0 -> 0;
        _ -> lists:min(sets:to_list(Candidates))
    end.