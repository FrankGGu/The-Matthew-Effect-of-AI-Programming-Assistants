-module(solution).
-export([solve/1]).

solve(Nums) ->
    % Create a frequency map for quick lookups and handling duplicates.
    % FreqMap stores {Number => Count} for all numbers in the input list Nums.
    FreqMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),

    % Get unique sorted numbers from the input list.
    % We iterate through these unique numbers to pick 'A' and 'B' for potential triplets.
    UniqueNums = lists:sort(maps:keys(FreqMap)),

    % Initialize an empty set to store unique triplets found.
    UniqueTriplets = sets:new(),

    % Start the outer loop for picking the first element 'A' of a triplet.
    find_triplets_optimized(UniqueNums, FreqMap, UniqueTriplets).

find_triplets_optimized([A | RestA], FreqMap, AccSet) ->
    % Inner loop (for B): Iterates through the remaining unique numbers (RestA) as the second element 'B'.
    % By taking B from RestA, we ensure A and B are distinct values.
    AccSet1 = find_triplets_j_optimized(A, RestA, FreqMap, AccSet),
    % Recurse for the next 'A' from the remaining unique numbers.
    find_triplets_optimized(RestA, FreqMap, AccSet1);
find_triplets_optimized([], _FreqMap, AccSet) ->
    % Base case: All unique 'A' values have been processed.
    % Return the total count of unique triplets found.
    sets:size(AccSet).

find_triplets_j_optimized(A, [B | RestB], FreqMap, AccSet) ->
    % Calculate the target value for the third element 'C' such that A XOR B XOR C = 0.
    % This means C = A XOR B.
    Target = A bxor B,

    NewAccSet = case maps:find(Target, FreqMap) of
        {ok, _TargetCount} ->
            % If 'Target' exists in the original list (checked via FreqMap),
            % we need to verify if we have enough occurrences of A, B, and Target
            % to form a valid triplet.

            % Count occurrences of A, B, and Target within the *current candidate triplet*.
            % This helps determine the minimum required counts from the original Nums list.
            Counts = #{A => 0, B => 0, Target => 0},
            Counts1 = maps:update_with(A, fun(V) -> V + 1 end, 1, Counts),
            Counts2 = maps:update_with(B, fun(V) -> V + 1 end, 1, Counts1),
            Counts3 = maps:update_with(Target, fun(V) -> V + 1 end, 1, Counts2),

            % Check if the original frequency map (FreqMap) has at least the required counts
            % for each element in the candidate triplet (Counts3).
            CanForm = maps:foldl(fun(Val, ReqCount, Acc) ->
                                     if Acc == false -> false; % Short-circuit if a previous check already failed
                                        true ->
                                            case maps:find(Val, FreqMap) of
                                                {ok, ActualCount} when ActualCount >= ReqCount -> true;
                                                _ -> false % Not enough count of 'Val' in the original list
                                            end
                                     end
                                 end, true, Counts3),

            % If we can form the triplet, add its canonical representation to the set.
            if CanForm -> sets:add(tuple_sort(A, B, Target), AccSet);
               true -> AccSet
            end;
        _ -> % Target is not present in the original list (FreqMap), so no triplet can be formed.
            AccSet
    end,
    % Recurse for the next 'B' from the remaining unique numbers.
    find_triplets_j_optimized(A, RestB, FreqMap, NewAccSet);
find_triplets_j_optimized(_A, [], _FreqMap, AccSet) ->
    % Base case: All 'B' values for the current 'A' have been processed.
    AccSet.

tuple_sort(A, B, C) ->
    L = lists:sort([A, B, C]),
    list_to_tuple(L).