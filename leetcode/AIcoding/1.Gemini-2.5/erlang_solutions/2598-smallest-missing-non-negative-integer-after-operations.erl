-module(solution).
-export([smallestMissingNonNegativeInteger/2]).

smallestMissingNonNegativeInteger(Nums, Value) ->
    % Step 1: Count remainders
    % Use a map to store counts for each remainder.
    % For each number N in Nums, calculate its remainder R = N rem Value.
    % Increment the count for R in the map.
    Counts = lists:foldl(fun(N, AccMap) ->
                             Remainder = N rem Value,
                             CurrentCount = maps:get(Remainder, AccMap, 0),
                             maps:put(Remainder, CurrentCount + 1, AccMap)
                         end, #{}, Nums),

    % Step 2: Find the smallest non-negative integer K
    % Iterate K = 0, 1, 2, ...
    % For each K, calculate its remainder R_K = K rem Value.
    % If the count for R_K in the map is 0, then K cannot be formed, and it's the answer.
    % Otherwise, decrement the count for R_K and continue to K+1.
    find_smallest_k(0, Counts, Value).

find_smallest_k(K, Counts, Value) ->
    Remainder = K rem Value,
    CurrentCount = maps:get(Remainder, Counts, 0), % If Remainder is not in map, its count is 0

    if CurrentCount == 0 ->
           K; % K cannot be formed, so it's the smallest missing non-negative integer
       true ->
           NewCounts = maps:put(Remainder, CurrentCount - 1, Counts),
           find_smallest_k(K + 1, NewCounts, Value) % Try to form K+1
    end.