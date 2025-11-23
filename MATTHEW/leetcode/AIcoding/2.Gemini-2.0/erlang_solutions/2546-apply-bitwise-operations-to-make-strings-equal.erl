-module(bitwise_equal).
-export([make_strings_equal/2]).

make_strings_equal(S, T) ->
    S_ones = count_ones(S),
    T_ones = count_ones(T),

    if S_ones == 0 and T_ones > 0 then
        false
    else
        if S_ones > 0 and T_ones == 0 then
            false
        else
            true
        end
    end.

count_ones(Str) ->
    count_ones(Str, 0).

count_ones([], Acc) ->
    Acc;
count_ones([H | T], Acc) ->
    if H == $1 then
        count_ones(T, Acc + 1)
    else
        count_ones(T, Acc)
    end.