-module(find_minimum_amount_of_time_to_brew_potions).
-export([min_potion_time/2]).

min_potion_time(potions, success_threshold) ->
    min_potion_time(potions, success_threshold, 0, lists:max(potions) * success_threshold).

min_potion_time(potions, success_threshold, Low, High) when Low >= High ->
    High;
min_potion_time(potions, success_threshold, Low, High) ->
    Mid = (Low + High) div 2,
    case check(potions, success_threshold, Mid) of
        true ->
            min_potion_time(potions, success_threshold, Low, Mid);
        false ->
            min_potion_time(potions, success_threshold, Mid + 1, High)
    end.

check(potions, success_threshold, Time) ->
    lists:foldl(fun(Potion, Acc) ->
                        Acc + math:ceil(float(Time) / float(Potion))
                end, 0, potions) =< success_threshold.