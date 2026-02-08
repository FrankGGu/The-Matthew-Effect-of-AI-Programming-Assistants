-module(solution).
-export([minimum_total_space_wasted_with_k_resizing_operations/2]).

-define(INF, 1_000_000_000_000_000_000_000).

minimum_total_space_wasted_with_k_resizing_operations(Nums, K) ->
    N = length(Nums),
    if N == 0 -> 0;
       true ->
            % Create an ETS table for memoization.
            % The table is automatically deleted when the process exits.
            ets:new(dp_cache, [set, protected, {read_concurrency, true}]),

            MaxMatrix = precompute_max_matrix(Nums, N),
            SumMatrix = precompute_sum_matrix(Nums, N),

            % K resizing operations allow for K+1 segments.
            dp(0, K + 1, N, MaxMatrix, SumMatrix)
    end.

precompute_max_matrix(Nums, N) ->
    % MaxMatrix[I][J] stores the maximum value in Nums[I..J].
    % It's an array of arrays for O(1) access after creation.
    MaxMatrix = array:new({0, N - 1}),
    lists:foldl(fun(I, AccMaxMatrix) ->
        RowArray = array:new({0, N - 1}),
        % CurrentMax starts at 0 because nums[i] >= 1.
        {FinalRowArray, _FinalMax} = lists:foldl(fun(J, {InnerAccRowArray, InnerAccMax}) ->
            Element = lists:nth(J + 1, Nums), % Nums is 1-indexed for lists:nth
            NewMax = max(InnerAccMax, Element),
            NewInnerAccRowArray = array:set(J, NewMax, InnerAccRowArray),
            {NewInnerAccRowArray, NewMax}
        end, {RowArray, 0}, lists:seq(I, N - 1)),
        array:set(I, FinalRowArray, AccMaxMatrix)
    end, MaxMatrix, lists:seq(0, N - 1)).

precompute_sum_matrix(Nums, N) ->
    % SumMatrix[I][J] stores the sum of values in Nums[I..J].
    % It's an array of arrays for O(1) access after creation.
    SumMatrix = array:new({0, N - 1}),
    lists:foldl(fun(I, AccSumMatrix) ->
        RowArray = array:new({0, N - 1}),
        % CurrentSum starts at 0.
        {FinalRowArray, _FinalSum} = lists:foldl(fun(J, {InnerAccRowArray, InnerAccSum}) ->
            Element = lists:nth(J + 1, Nums), % Nums is 1-indexed for lists:nth
            NewSum = InnerAccSum + Element,
            NewInnerAccRowArray = array:set(J, NewSum, InnerAccRowArray),
            {NewInnerAccRowArray, NewSum}
        end, {RowArray, 0}, lists:seq(I, N - 1)),
        array:set(I, FinalRowArray, AccSumMatrix)
    end, SumMatrix, lists:seq(0, N - 1)).

dp(Idx, RemainingSegments, N, MaxMatrix, SumMatrix) ->
    Key = {Idx, RemainingSegments},
    case ets:lookup(dp_cache, Key) of
        [{Key, Value}] -> Value;
        [] ->
            Result =
                if Idx == N -> 0; % All elements processed, no more waste.
                   RemainingSegments == 0 -> ?INF; % Cannot form more segments but elements remain.
                   true ->
                       MinWaste = ?INF,
                       lists:foldl(fun(J, CurrentMinWaste) ->
                           % Calculate waste for the current segment Nums[Idx..J]
                           CurrentMax = array:get(J, array:get(Idx, MaxMatrix)),
                           CurrentSum = array:get(J, array:get(Idx, SumMatrix)),
                           NumElements = J - Idx + 1,
                           CurrentBlockWaste = NumElements * CurrentMax - CurrentSum,

                           % Recursively find waste for the rest of the array
                           RemainingWaste = dp(J + 1, RemainingSegments - 1, N, MaxMatrix, SumMatrix),
                           TotalWaste = CurrentBlockWaste + RemainingWaste,
                           min(CurrentMinWaste, TotalWaste)
                       end, MinWaste, lists:seq(Idx, N - 1))
                end,
            ets:insert(dp_cache, {Key, Result}),
            Result
    end.