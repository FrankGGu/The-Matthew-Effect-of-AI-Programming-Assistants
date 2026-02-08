-module(solution).
-export([min_changes/2]).

min_changes(Nums, K) ->
    N = length(Nums),

    % Base case: If N=1, no adjacent differences, so 0 changes needed.
    if N =:= 1 ->
        0;
    true ->
        % Calculate the maximum possible absolute difference D.
        % An arithmetic progression A, A+D, ..., A+(N-1)D must have all its terms
        % within the range [1, K].
        % If D >= 0: A >= 1 and A+(N-1)D <= K => D <= (K-1)/(N-1)
        % If D < 0: A <= K and A+(N-1)D >= 1 => D >= -(K-1)/(N-1)
        % So, D must be in the range [-(K-1)/(N-1), (K-1)/(N-1)].
        MaxAbsD = (K - 1) div (N - 1),

        MinTotalChanges = N, % Initialize with the maximum possible changes (change all elements)

        % Pre-process Nums to have (index, value) pairs for efficient iteration
        IndexedNums = lists:zip(lists:seq(0, N - 1), Nums),

        % Iterate through all possible common differences D
        lists:foldl(
            fun(D, AccMinChanges) ->
                % Calculate the valid range for A (the first element of the arithmetic progression)
                % For each i, 1 <= A + i*D <= K.
                % This implies A >= 1 - i*D and A <= K - i*D.
                % So, A must be in [max(1 - i*D), min(K - i*D)] for all i.
                MinABound = lists:foldl(fun(I, CurrentMin) -> max(CurrentMin, 1 - I * D) end, 1, lists:seq(0, N - 1)),
                MaxABound = lists:foldl(fun(I, CurrentMax) -> min(CurrentMax, K - I * D) end, K, lists:seq(0, N - 1)),

                % If the calculated range for A is invalid (MinABound > MaxABound),
                % then no such arithmetic progression exists for this D.
                if MinABound > MaxABound ->
                    AccMinChanges;
                true ->
                    % Build a frequency map for (NumI - I*D) values.
                    % These values are potential 'A's if NumI is kept unchanged.
                    FreqMap = maps:new(),
                    FreqMapFinal = lists:foldl(
                        fun({I, NumI}, CurrentFreqMap) ->
                            % Only consider nums[i] that are within the allowed range [1, K]
                            % If nums[i] is outside this range, it must be changed regardless.
                            if NumI >= 1 andalso NumI =< K ->
                                TargetAVal = NumI - I * D,
                                maps:update_with(TargetAVal, fun(V) -> V + 1 end, 1, CurrentFreqMap);
                            true ->
                                CurrentFreqMap
                            end
                        end, FreqMap, IndexedNums),

                    % Find the maximum frequency among the 'A' values that fall within
                    % the valid range [MinABound, MaxABound].
                    MaxFreq = lists:foldl(
                        fun({AVal, Count}, CurrentMaxFreq) ->
                            if AVal >= MinABound andalso AVal =< MaxABound ->
                                max(CurrentMaxFreq, Count);
                            true ->
                                CurrentMaxFreq
                            end
                        end, 0, maps:to_list(FreqMapFinal)),

                    % The number of changes for this D is N - MaxFreq.
                    % Update the overall minimum changes found so far.
                    CurrentChanges = N - MaxFreq,
                    min(AccMinChanges, CurrentChanges)
                end
            end, MinTotalChanges, lists:seq(-MaxAbsD, MaxAbsD))
    end.