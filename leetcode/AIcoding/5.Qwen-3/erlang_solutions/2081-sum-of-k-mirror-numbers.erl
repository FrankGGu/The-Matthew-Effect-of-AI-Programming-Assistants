-module(solution).
-export([kmirror/2]).

kmirror(K, N) ->
    kmirror(K, N, 1, 0, []).

kmirror(_K, _N, _Num, _Count, _Acc) when _Count == _N ->
    lists:sum(lists:reverse(_Acc));
kmirror(K, N, Num, Count, Acc) ->
    case is_kmirror(Num, K) of
        true ->
            kmirror(K, N, Num + 1, Count + 1, [Num | Acc]);
        false ->
            kmirror(K, N, Num + 1, Count, Acc)
    end.

is_kmirror(Num, K) ->
    is_palindrome(Num) andalso is_palindrome_base(Num, K).

is_palindrome(N) ->
    is_palindrome(integer_to_list(N)).

is_palindrome(S) ->
    S == lists:reverse(S).

is_palindrome_base(N, Base) ->
    is_palindrome(integer_to_base(N, Base)).

integer_to_base(N, Base) ->
    integer_to_base(N, Base, []).

integer_to_base(0, _, Acc) ->
    if Acc == [] -> [0]; true -> Acc end;
integer_to_base(N, Base, Acc) ->
    integer_to_base(N div Base, Base, [N rem Base | Acc]).