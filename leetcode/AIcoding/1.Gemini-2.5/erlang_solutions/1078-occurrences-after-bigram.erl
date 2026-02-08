-module(solution).
-export([findOcurrences/3]).

findOcurrences(Text, First, Second) ->
    Words = string:tokens(Text, " "),
    find_ocurrences_recursive(Words, First, Second, []).

find_ocurrences_recursive([W1, W2, W3 | Rest], First, Second, Acc) when W1 =:= First, W2 =:= Second ->
    find_ocurrences_recursive([W2, W3 | Rest], First, Second, [W3 | Acc]);
find_ocurrences_recursive([_W1, W2, W3 | Rest], First, Second, Acc) ->
    find_ocurrences_recursive([W2, W3 | Rest], First, Second, Acc);
find_ocurrences_recursive(_, _First, _Second, Acc) ->
    lists:reverse(Acc).