-module(solver).
-export([k_mirror/2]).

k_mirror(K, N) ->
    lists:sum(lists:map(fun(X) -> if is_k_mirror(X, K) -> X; true -> 0 end end, lists:seq(1, N))).

is_k_mirror(X, K) ->
    BaseK = integer_to_list(X, K),
    lists:reverse(BaseK) =:= BaseK andalso is_palindrome(X).

integer_to_list(0, _) -> "0";
integer_to_list(N, B) -> 
    case N rem B of
        R when R < 10 -> integer_to_list(N div B, B) ++ [char_list(R)];
        R -> integer_to_list(N div B, B) ++ [char_list(R + 87)]
    end.

char_list(N) when N < 10 -> $0 + N;
char_list(N) -> $a + (N - 10).

is_palindrome(L) -> L =:= lists:reverse(L).