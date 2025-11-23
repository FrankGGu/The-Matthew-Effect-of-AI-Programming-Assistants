-module(conquer_the_base).
-export([conquer/1]).

conquer(armor) ->
    conquer(armor, 0, 0).

conquer([], Acc, _Damage) ->
    Acc;
conquer([H|T], Acc, Damage) ->
    case H > Damage of
        true ->
            conquer(T, Acc + 1, H);
        false ->
            conquer(T, Acc, Damage)
    end.