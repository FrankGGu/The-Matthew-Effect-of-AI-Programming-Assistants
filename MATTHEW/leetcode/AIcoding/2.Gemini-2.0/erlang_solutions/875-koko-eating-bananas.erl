-module(koko_eating_bananas).
-export([min_eating_speed/2]).

min_eating_speed(Piles, H) ->
  min_eating_speed(Piles, H, 1, lists:max(Piles)).

min_eating_speed(Piles, H, Low, High) ->
  if Low > High ->
    Low;
  true ->
    Mid = (Low + High) div 2,
    Time = calculate_time(Piles, Mid),
    if Time > H ->
      min_eating_speed(Piles, H, Mid + 1, High);
    true ->
      min_eating_speed(Piles, H, Low, Mid - 1)
    end
  end.

calculate_time(Piles, K) ->
  lists:sum([math:ceil(P / K) || P <- Piles]).