-module(solution).
-export([has_pattern/2]).

has_pattern(Arr, M) ->
    N = length(Arr),
    K = 1,
    has_pattern(Arr, M, N, K).

has_pattern(_Arr, _M, _N, _K) when _M > _N -> false;
has_pattern(Arr, M, N, K) ->
    lists:any(fun(I) -> check_pattern(Arr, I, M, K) end, lists:seq(0, N - M * K)).

check_pattern(_Arr, _I, _M, _K) when _K == 0 -> true;
check_pattern(Arr, I, M, K) ->
    Start = I,
    End = I + M * K,
    if
        End > length(Arr) -> false;
        true ->
            lists:all(fun(J) -> 
                lists:sublist(Arr, Start + J*M, M) == lists:sublist(Arr, Start + (J+1)*M, M)
            end, lists:seq(0, K-1))
    end.