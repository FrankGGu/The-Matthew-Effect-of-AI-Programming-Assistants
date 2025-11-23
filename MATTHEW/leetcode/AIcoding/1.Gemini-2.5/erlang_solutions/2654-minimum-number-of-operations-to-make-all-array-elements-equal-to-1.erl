-module(solution).
-export([minOperations/1]).

minOperations(Nums) ->
    N = length(Nums),
    OnesCount = lists:foldl(fun(X, Acc) -> if X == 1 -> Acc + 1; true -> Acc end end, 0, Nums),

    if
        OnesCount > 0 ->
            N - OnesCount;
        true ->
            MinOpsToCreateOne = find_min_ops_to_create_one(Nums, N),
            if
                MinOpsToCreateOne == ?INFINITY ->
                    -1;
                true ->
                    MinOpsToCreateOne + (N - 1)
            end
    end.

find_min_ops_to_create_one(Nums, N) ->
    MinOps = lists:foldl(fun(I, CurrentMinOps) ->
        lists:foldl(fun(J, InnerMinOps) ->
            Subarray = lists:sublist(Nums, I + 1, J - I + 1),
            GCD = lists:foldl(fun(X, Acc) -> math:gcd(X, Acc) end, hd(Subarray), tl(Subarray)),
            if
                GCD == 1 ->
                    OpsForThisSubarray = J - I,
                    min(InnerMinOps, OpsForThisSubarray);
                true ->
                    InnerMinOps
            end
        end, CurrentMinOps, lists:seq(I, N - 1))
    end, ?INFINITY, lists:seq(0, N - 1)),
    MinOps.

min(A, B) when A < B -> A;
min(A, B) -> B.

-define(INFINITY, 1000000000).