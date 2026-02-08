-spec can_eat_favorite_candy(CandiesCount :: [integer()], Queries :: [[integer()]]) -> [boolean()].
can_eat_favorite_candy(CandiesCount, Queries) ->
    Prefix = lists:foldl(fun(X, Acc) -> 
                            case Acc of
                                [] -> [X];
                                _ -> [hd(Acc) + X | Acc]
                            end
                         end, [], CandiesCount),
    PrefixSum = lists:reverse(Prefix),
    lists:map(fun([FavoriteType, FavoriteDay, DailyCap]) ->
                  Total = if FavoriteType == 0 -> 0;
                             true -> lists:nth(FavoriteType, PrefixSum)
                          end,
                  MinCandies = FavoriteDay + 1,
                  MaxCandies = (FavoriteDay + 1) * DailyCap,
                  (MinCandies =< (if FavoriteType + 1 > length(PrefixSum) -> 
                                      lists:last(PrefixSum);
                                   true -> lists:nth(FavoriteType + 1, PrefixSum)
                                end)) andalso
                  (MaxCandies > Total)
              end, Queries).