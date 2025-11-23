-module(solution).
-export([minimum_xor_sum/2]).

minimum_xor_sum(A, B) ->
    N = length(A),
    M = length(B),
    AllMask = (1 bsl N) - 1,
    MinXorSum = minimum_xor_sum_helper(A, B, 0, 0, AllMask, []).

minimum_xor_sum_helper(_, _, _, Sum, AllMask, _) when Sum band AllMask == AllMask ->
    %% All elements have been used
    0;
minimum_xor_sum_helper(A, B, Mask, Sum, AllMask, Used) ->
    lists:foldl(fun(Index, Acc) ->
        case lists:nth(Index + 1, Used) of
            true -> Acc;
            false ->
                NewMask = Mask bor (1 bsl Index),
                NewUsed = lists:duplicate(length(A), false),
                NewUsed = lists:replace(NewUsed, Index, true),
                XorSum = lists:nth(Index + 1, A) bxor lists:nth(Index + 1, B),
                Acc1 = XorSum + minimum_xor_sum_helper(A, B, NewMask, Sum + XorSum, AllMask, NewUsed),
                min(Acc, Acc1)
        end
    end, infinity, lists:seq(0, N - 1)).

min(A, B) -> if A < B -> A; true -> B end.