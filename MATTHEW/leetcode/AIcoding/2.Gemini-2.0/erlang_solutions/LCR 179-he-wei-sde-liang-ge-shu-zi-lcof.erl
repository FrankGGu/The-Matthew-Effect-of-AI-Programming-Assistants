-module(solution).
-export([two_sum/2]).

two_sum(Prices, Target) ->
  find_sum(Prices, Target, []).

find_sum([], _, _) ->
  [];
find_sum([Price | Rest], Target, Seen) ->
  case lists:member(Target - Price, Seen) of
    true ->
      [Price, Target - Price];
    false ->
      find_sum(Rest, Target, [Price | Seen])
  end.