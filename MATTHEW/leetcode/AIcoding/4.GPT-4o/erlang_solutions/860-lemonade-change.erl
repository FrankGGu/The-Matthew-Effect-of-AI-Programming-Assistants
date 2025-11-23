-module(solution).
-export([lemonadeChange/1]).

lemonadeChange(Bills) ->
    lemonadeChange(Bills, 0, 0).

lemonadeChange([], _Five, _Ten) -> 
    true;
lemonadeChange([5 | Rest], Five, Ten) -> 
    lemonadeChange(Rest, Five + 1, Ten);
lemonadeChange([10 | Rest], Five, Ten) when Five > 0 -> 
    lemonadeChange(Rest, Five - 1, Ten + 1);
lemonadeChange([10 | _Rest], _Five, _Ten) -> 
    false;
lemonadeChange([20 | Rest], Five, Ten) when Ten > 0, Five > 0 -> 
    lemonadeChange(Rest, Five - 1, Ten - 1);
lemonadeChange([20 | Rest], Five, _Ten) when Five >= 3 -> 
    lemonadeChange(Rest, Five - 3, 0);
lemonadeChange([20 | _Rest], _Five, _Ten) -> 
    false.