-module(solution).
-export([superpalindromesinrange/2]).

is_palindrome(N) when N < 0 -> false;
is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).

superpalindromesinrange(L_str, R_str) ->
    L = list_to_integer(L_str),
    R = list_to_integer(R_str),

    MaxK = 100000, 

    superpalindromes_loop(1, MaxK, L, R, 0).

superpalindromes_loop(K, MaxK, L, R, Acc) when K >= MaxK ->
    Acc;
superpalindromes_loop(K, MaxK, L, R, Acc) ->
    S_k = integer_to_list(K),

    S_k_rev = lists:reverse(S_k),
    X_even_str = S_k ++ S_k_rev,
    X_even = list_to_integer(X_even_str),

    NewAcc1 = 
        if X_even > 1000000000 -> 
            Acc;
           true ->
               Sq_even = X_even * X_even,
               if Sq_even > R ->
                   Acc;
                  Sq_even < L ->
                   Acc;
                  is_palindrome(Sq_even) ->
                   Acc + 1;
                  true ->
                   Acc
               end
        end,

    S_k_rev_suffix = lists:reverse(lists:droplast(S_k)),
    X_odd_str = S_k ++ S_k_rev_suffix,
    X_odd = list_to_integer(X_odd_str),

    NewAcc2 = 
        if X_odd > 1000000000 -> 
            NewAcc1;
           true ->
               Sq_odd = X_odd * X_odd,
               if Sq_odd > R ->
                   NewAcc1;
                  Sq_odd < L ->
                   NewAcc1;
                  is_palindrome(Sq_odd) ->
                   NewAcc1 + 1;
                  true ->
                   NewAcc1
               end
        end,

    superpalindromes_loop(K + 1, MaxK, L, R, NewAcc2).