-module(solution).
-export([sort_jumbled/1]).

sort_jumbled(Numbers) ->
    lists:sort(fun(A, B) -> 
        KeyA = jumble_key(A),
        KeyB = jumble_key(B),
        KeyA =< KeyB
    end, Numbers).

jumble_key(Number) ->
    Jumbled = jumble_digits(Number),
    list_to_integer(Jumbled).

jumble_digits(Number) ->
    Digits = integer_to_list(Number),
    lists:foldl(fun(D, Acc) -> [D | Acc] end, [], Digits).