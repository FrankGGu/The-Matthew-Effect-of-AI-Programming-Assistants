-module(sliding_subarray_beauty).
-export([get_beauty/2]).

get_beauty(A, K) ->
    N = length(A),
    if
        K > N orelse K <= 0 ->
            [];
        true ->
            lists:map(fun(I) -> get_subarray_beauty(A, I, K) end, lists:seq(1, N - K + 1))
    end.

get_subarray_beauty(A, Start, K) ->
    Subarray = lists:sublist(A, Start, K),
    MinElem = lists:min(Subarray),
    lists:foldl(fun(X, Acc) -> if X < MinElem -> Acc + 1; true -> Acc end end, 0, Subarray).