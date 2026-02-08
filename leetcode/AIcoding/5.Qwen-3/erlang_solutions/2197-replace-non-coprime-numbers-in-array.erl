-module(replace_non_coprime_numbers_in_array).
-export([run/1]).

run(Nums) ->
    do_run(Nums).

do_run([]) ->
    [];
do_run([H | T]) ->
    do_run(T, H, []).

do_run([], Acc, Result) ->
    lists:reverse([Acc | Result]);
do_run([H | T], Acc, Result) ->
    case gcd(Acc, H) of
        1 ->
            do_run(T, H, [Acc | Result]);
        G ->
            do_run(T, Acc * H div G, Result)
    end.

gcd(A, B) when A == 0 ->
    B;
gcd(A, B) when B == 0 ->
    A;
gcd(A, B) when A < B ->
    gcd(B, A);
gcd(A, B) ->
    gcd(B, A rem B).