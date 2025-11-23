-module(solution).
-export([num_subarrays/2]).

num_subarrays(Nums, L) ->
    num_subarrays(Nums, L, 0, 0, 0).

num_subarrays([], _, _, _, Acc) ->
    Acc;
num_subarrays([N | T], L, Left, Right, Acc) ->
    if
        N < L ->
            num_subarrays(T, L, Left, Right, Acc);
        true ->
            NewRight = Right + 1,
            case N of
                _ when N > L ->
                    num_subarrays(T, L, NewRight, NewRight, Acc + (NewRight * (NewRight + 1)) div 2);
                _ ->
                    num_subarrays(T, L, Left, NewRight, Acc + (NewRight * (NewRight + 1)) div 2)
            end
    end.