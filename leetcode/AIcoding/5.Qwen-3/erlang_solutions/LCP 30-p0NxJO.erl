-module(tower_game).
-export([calculate/1]).

calculate(Towers) ->
    calculate(Towers, 0, 0).

calculate([], _, _) ->
    0;
calculate([{Health, Attack} | Rest], CurrentHealth, TotalDamage) ->
    if
        CurrentHealth =< 0 ->
            -1;
        true ->
            NewHealth = CurrentHealth - Attack,
            NewDamage = TotalDamage + Health,
            calculate(Rest, NewHealth, NewDamage)
    end.