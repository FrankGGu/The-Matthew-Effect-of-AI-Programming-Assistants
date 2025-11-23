-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    N = length(Nums),
    Count = 0,
    I = 0,
    num_subarrays(Nums, N, I, Count).

num_subarrays(_, _, N, Count) when N == 0 ->
    Count;
num_subarrays(Nums, N, I, Count) ->
    J = I,
    num_subarrays(Nums, N, I, J, Count).

num_subarrays(_, _, _, J, Count) when J >= N ->
    num_subarrays(Nums, N, I+1, Count);
num_subarrays(Nums, N, I, J, Count) ->
    Sub = lists:sublist(Nums, I+1, J-I),
    case is_increasing(Sub) of
        true ->
            num_subarrays(Nums, N, I, J+1, Count + 1);
        false ->
            num_subarrays(Nums, N, I, J+1, Count)
    end.

is_increasing([]) ->
    true;
is_increasing([_]) ->
    true;
is_increasing([A | [B | T]]) ->
    if A < B -> is_increasing([B | T]);
       true -> false
    end.