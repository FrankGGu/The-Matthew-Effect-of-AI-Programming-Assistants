-module(candy_eater).
-export([can_eat_favorite_candy/2]).

can_eat_favorite_candy(CandiesCount, Queries) ->
  PrefixSum = lists:foldl(
    fun(X, Acc) -> [lists:last(Acc) + X | Acc] end,
    [0],
    CandiesCount
  ),
  PrefixSumReversed = lists:reverse(PrefixSum),
  lists:map(
    fun([FavoriteType, FavoriteDay, DailyCap]) ->
      CanEat(FavoriteType, FavoriteDay, DailyCap, PrefixSumReversed)
    end,
    Queries
  ).

CanEat(FavoriteType, FavoriteDay, DailyCap, PrefixSum) ->
  MaxEat = DailyCap * (FavoriteDay + 1),
  MinEat = FavoriteDay + 1,
  TotalBefore = lists:nth(FavoriteType + 1, PrefixSum),
  TotalOfFavTypeAndBefore = lists:nth(FavoriteType + 2, PrefixSum),
  (MaxEat > TotalBefore) and (MinEat <= TotalOfFavTypeAndBefore).