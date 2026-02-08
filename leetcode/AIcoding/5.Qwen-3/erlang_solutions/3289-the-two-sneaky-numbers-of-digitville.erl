-module(solution).
-export([two_sneaky_numbers/1]).

two_sneaky_numbers(Digits) ->
    Counts = lists:foldl(fun(X, Acc) -> dict:update_counter(X, 1, Acc) end, dict:new(), Digits),
    Keys = dict:keys(Counts),
    lists:filter(fun(K) -> dict:fetch(K, Counts) == 2 end, Keys).