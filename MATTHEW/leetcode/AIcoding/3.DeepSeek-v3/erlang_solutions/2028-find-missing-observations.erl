-spec missing_rolls(Rolls :: [integer()], Mean :: integer(), N :: integer()) -> [integer()].
missing_rolls(Rolls, Mean, M) ->
    Total = Mean * (length(Rolls) + M),
    SumRolls = lists:sum(Rolls),
    MissingSum = Total - SumRolls,
    if
        MissingSum < M orelse MissingSum > 6 * M -> [];
        true ->
            Base = MissingSum div M,
            Rem = MissingSum rem M,
            lists:duplicate(Rem, Base + 1) ++ lists:duplicate(M - Rem, Base)
    end.