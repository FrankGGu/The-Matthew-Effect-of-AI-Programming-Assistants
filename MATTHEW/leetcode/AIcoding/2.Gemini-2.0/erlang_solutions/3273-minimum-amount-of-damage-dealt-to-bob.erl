-module(minimum_damage).
-export([minimum_amount_of_damage/2]).

minimum_amount_of_damage(amount, bob_health) ->
  minimum_amount_of_damage(amount, bob_health, []).

minimum_amount_of_damage([], Health) ->
  Health;
minimum_amount_of_damage([H|T], Health) ->
  minimum_amount_of_damage(T, max(0, Health - H)).