-module(solution).
-export([maximum_value_sum/2]).

-spec maximum_value_sum(Nums :: [integer()], K :: integer()) -> integer().
maximum_value_sum(Nums, K) ->
    % Initial accumulator state:
    % {BaseSum, CurrentGain, NumXored, MinPositiveGain, MaxNegativeGain}
    % BaseSum: Sum of original values (nums[i])
    % CurrentGain: Sum of positive (nums[i] XOR K - nums[i]) differences
    % NumXored: Count of nodes where (nums[i] XOR K - nums[i]) > 0
    % MinPositiveGain: Smallest positive difference
    % MaxNegativeGain: Largest (closest to zero) non-positive difference

    % Using large/small numbers for min/max initial values.
    % Erlang integers handle arbitrary precision, so these are fine.
    Infinity = 100000000000000000000000000000000000000, % A sufficiently large number
    NegativeInfinity = -Infinity, % A sufficiently small number

    InitialAcc = {0, 0, 0, Infinity, NegativeInfinity},

    {BaseSum, CurrentGain, NumXored, MinPositiveGain, MaxNegativeGain} = 
        lists:foldl(fun(X, {AccSum, AccGain, AccNumXored, AccMinPos, AccMaxNeg}) ->
                        XorX = bxor(X, K),
                        Diff = XorX - X,

                        NewAccSum = AccSum + X,

                        if Diff > 0 ->
                                {NewAccSum, AccGain + Diff, AccNumXored + 1, min(AccMinPos, Diff), AccMaxNeg};
                           true -> % Diff <= 0
                                {NewAccSum, AccGain, AccNumXored, AccMinPos, max(AccMaxNeg, Diff)}
                        end
                    end, InitialAcc, Nums),

    % The sum if we XOR all nodes that give a positive gain.
    ProposedSum = BaseSum + CurrentGain,

    % Check parity of NumXored.
    % If even, ProposedSum is achievable.
    % If odd, we must adjust by either:
    % 1. Not XORing the node with the smallest positive gain (cost: MinPositiveGain)
    % 2. XORing a node with a non-positive gain, choosing the one that minimizes loss (cost: -MaxNegativeGain)
    if (NumXored rem 2) == 0 ->
            ProposedSum;
       true -> % NumXored is odd
            ProposedSum - min(MinPositiveGain, -MaxNegativeGain)
    end.