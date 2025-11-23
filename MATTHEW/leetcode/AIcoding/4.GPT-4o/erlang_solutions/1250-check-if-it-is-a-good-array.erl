-module(solution).
-export([is_good_array/1]).

is_good_array(A) ->
    gcd_list(A) =:= 1.

gcd_list([]) ->
    0;
gcd_list([H|T]) ->
    gcd_list_helper(H, T).

gcd_list_helper(X, []) ->
    X;
gcd_list_helper(X, [H|T]) ->
    gcd_list_helper(gcd(X, H), T).

gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).