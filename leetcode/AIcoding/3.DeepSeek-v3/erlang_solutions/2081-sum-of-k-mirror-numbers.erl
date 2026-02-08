-module(solution).
-export([k_mirror/2]).

k_mirror(K, N) ->
    Sum = 0,
    Count = 0,
    Num = 1,
    find_k_mirror(K, N, Sum, Count, Num).

find_k_mirror(_K, N, Sum, Count, _Num) when Count >= N ->
    Sum;
find_k_mirror(K, N, Sum, Count, Num) ->
    case is_palindrome(Num) andalso is_k_palindrome(Num, K) of
        true ->
            find_k_mirror(K, N, Sum + Num, Count + 1, Num + 1);
        false ->
            find_k_mirror(K, N, Sum, Count, Num + 1)
    end.

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).

is_k_palindrome(N, K) ->
    S = to_base(N, K),
    S == lists:reverse(S).

to_base(N, K) ->
    to_base(N, K, []).

to_base(0, _K, Acc) ->
    Acc;
to_base(N, K, Acc) ->
    Digit = N rem K,
    to_base(N div K, K, [integer_to_list(Digit) | Acc]).