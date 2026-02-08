-module(super_pow).
-export([super_pow/2]).

base_pow(A, B, Mod) ->
    base_pow(A, B, Mod, 1).

base_pow(_, 0, _, Acc) ->
    Acc;
base_pow(A, B, Mod, Acc) ->
    if
        B rem 2 == 1 ->
            base_pow((A * A) rem Mod, B div 2, Mod, (Acc * A) rem Mod);
        true ->
            base_pow((A * A) rem Mod, B div 2, Mod, Acc)
    end.

super_pow(A, B) ->
    Mod = 1337,
    super_pow(A, B, Mod).

super_pow(A, [H], Mod) ->
    base_pow(A, H, Mod);
super_pow(A, B, Mod) ->
    Last = lists:last(B),
    Rest = lists:sublist(B, 1, length(B) - 1),
    (base_pow(A, Last, Mod) * base_pow(super_pow(A, Rest, Mod), 10, Mod)) rem Mod.