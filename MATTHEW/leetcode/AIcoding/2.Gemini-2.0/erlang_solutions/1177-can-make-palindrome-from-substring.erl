-module(can_make_palindrome).
-export([can_make_paliQueries/2]).

can_make_paliQueries(S, Queries) ->
    Prefix := prefix_xor(S),
    [can_make_palindrome(Prefix, Q) || Q <- Queries].

prefix_xor(S) ->
    prefix_xor(S, 0, []).

prefix_xor([], _, Acc) ->
    lists:reverse(Acc);
prefix_xor([H|T], Xor, Acc) ->
    NewXor = Xor bxor (1 bsl (H - $a)),
    prefix_xor(T, NewXor, [NewXor|Acc]).

can_make_palindrome(Prefix, [L, R, K]) ->
    Xor = lists:nth(R + 2, Prefix) bxor lists:nth(L + 1, Prefix),
    SetBits = count_set_bits(Xor),
    SetBits div 2 =< K.

count_set_bits(0) ->
    0;
count_set_bits(N) ->
    (N band 1) + count_set_bits(N bsr 1).