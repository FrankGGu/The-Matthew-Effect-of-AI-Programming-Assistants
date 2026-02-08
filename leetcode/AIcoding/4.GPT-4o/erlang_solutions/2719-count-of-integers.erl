-module(solution).
-export([countIntegers/3]).

countIntegers(Lower, Upper, K) ->
    count_integers(Lower, Upper, K, 0).

count_integers(Lower, Upper, K, Count) when Lower > Upper ->
    Count;
count_integers(Lower, Upper, K, Count) ->
    if
        has_digit(Lower, K) ->
            count_integers(Lower + 1, Upper, K, Count + 1);
        true ->
            count_integers(Lower + 1, Upper, K, Count)
    end.

has_digit(Number, K) ->
    lists:any(fun(Digit) -> Digit =:= K end, integer_to_list(Number)).