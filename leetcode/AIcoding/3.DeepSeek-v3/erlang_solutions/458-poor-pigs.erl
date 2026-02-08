-spec poor_pigs(Buckets :: integer(), MinutesToDie :: integer(), MinutesToTest :: integer()) -> integer().
poor_pigs(Buckets, MinutesToDie, MinutesToTest) ->
    T = MinutesToTest div MinutesToDie,
    find_min_pigs(Buckets, T + 1, 0).

find_min_pigs(Buckets, Base, Pigs) ->
    case math:pow(Base, Pigs) >= Buckets of
        true -> Pigs;
        false -> find_min_pigs(Buckets, Base, Pigs + 1)
    end.