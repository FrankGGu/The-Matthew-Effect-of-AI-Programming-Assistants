-module(solution).
-export([lemonade_change/1]).

lemonade_change(Bills) ->
    lemonade_change(Bills, 0, 0).

lemonade_change([], _Fives, _Tens) ->
    true;
lemonade_change([5 | Rest], Fives, Tens) ->
    lemonade_change(Rest, Fives + 1, Tens);
lemonade_change([10 | Rest], Fives, Tens) when Fives > 0 ->
    lemonade_change(Rest, Fives - 1, Tens + 1);
lemonade_change([10 | _Rest], _Fives, _Tens) ->
    false;
lemonade_change([20 | Rest], Fives, Tens) when Tens > 0 andalso Fives > 0 ->
    lemonade_change(Rest, Fives - 1, Tens - 1);
lemonade_change([20 | Rest], Fives, Tens) when Fives >= 3 ->
    lemonade_change(Rest, Fives - 3, Tens);
lemonade_change([20 | _Rest], _Fives, _Tens) ->
    false.