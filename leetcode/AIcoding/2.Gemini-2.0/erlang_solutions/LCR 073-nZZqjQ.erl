-module(banana_eating).
-export([minEatingSpeed/1]).

minEatingSpeed(piles) ->
  minEatingSpeed(piles, 1, lists:max(piles)).

minEatingSpeed(piles, Low, High) ->
  if
    Low > High ->
      Low;
    true ->
      Mid = Low + (High - Low) div 2,
      if
        canEatAll(piles, Mid) ->
          minEatingSpeed(piles, Low, Mid - 1);
        true ->
          minEatingSpeed(piles, Mid + 1, High)
      end
  end.

canEatAll(piles, K) ->
  Hours = lists:sum([math:ceil(P / K) || P <- piles]),
  Hours =< 8.