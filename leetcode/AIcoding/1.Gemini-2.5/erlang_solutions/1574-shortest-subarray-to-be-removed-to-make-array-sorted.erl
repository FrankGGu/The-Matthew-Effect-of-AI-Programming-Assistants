-module(solution).
-export([findLengthOfShortestSubarray/1]).

findLengthOfShortestSubarray(Arr) ->
    N = length(Arr),
    if N =< 1 -> 0;
       true ->
            % Convert list to tuple for O(1) indexed access
            % Erlang tuples are 1-indexed, so element(Idx + 1, TArr) corresponds to Arr[Idx]
            TArr = list_to_tuple(Arr),

            % Find L: the largest index such that Arr[0..L] is sorted (0-indexed)
            L = find_L(TArr, N, 0),

            % If the entire array is already sorted, no removal needed
            if L == N - 1 -> 0;
               true ->
                    % Find R: the smallest index such that Arr[R..N-1] is sorted (0-indexed)
                    R = find_R(TArr, N, N - 1),

                    % Initial minimum removal length:
                    % 1. Remove the suffix Arr[L+1 .. N-1]. Length: (N-1) - (L+1) + 1 = N - 1 - L.
                    % 2. Remove the prefix Arr[0 .. R-1]. Length: (R-1) - 0 + 1 = R.
                    MinRemoved = min(N - 1 - L, R),

                    % Two pointers approach to find the shortest subarray to remove
                    % by combining a sorted prefix Arr[0..I] and a sorted suffix Arr[J..N-1].
                    % I iterates from 0 to L (inclusive).
                    % J pointer starts from R and only moves forward.
                    % We want to find the minimum of (J - I - 1) for valid (I, J) pairs.
                    two_pointers(TArr, N, L, R, 0, R, MinRemoved)
            end
    end.

find_L(TArr, N, Idx) ->
    if Idx + 1 < N andalso element(Idx + 1, TArr) =< element(Idx + 2, TArr) ->
        find_L(TArr, N, Idx + 1);
    true ->
        Idx
    end.

find_R(TArr, N, Idx) ->
    if Idx - 1 >= 0 andalso element(Idx, TArr) =< element(Idx + 1, TArr) ->
        find_R(TArr, N, Idx - 1);
    true ->
        Idx
    end.

two_pointers(TArr, N, L, R, I, J, AccMinRemoved) ->
    if I =< L ->
        % Find the smallest J (starting from max(R, previous J, I+1)) such that TArr[I] <= TArr[J]
        CurrentJ = skip_j(TArr, N, R, I, J),
        if CurrentJ < N ->
            % A valid pair (I, CurrentJ) is found.
            % The subarray removed is TArr[I+1 .. CurrentJ-1].
            % Its length is (CurrentJ - 1) - (I + 1) + 1 = CurrentJ - I - 1.
            NewMinRemoved = min(AccMinRemoved, CurrentJ - I - 1),
            % Move to the next I, keeping CurrentJ as the starting point for the next search
            two_pointers(TArr, N, L, R, I + 1, CurrentJ, NewMinRemoved);
        true ->
            % No valid J found for current I (and thus for any subsequent I, as TArr[I] is non-decreasing)
            AccMinRemoved
        end;
    true ->
        AccMinRemoved
    end.

skip_j(TArr, N, R, I, CurrentJ) ->
    % Ensure J starts at least at R, and also J must be strictly greater than I.
    % CurrentJ is already >= R from previous calls.
    % So, the starting point for J for the current I is max(CurrentJ, I + 1).
    EffectiveJ = max(CurrentJ, I + 1),
    skip_j_loop(TArr, N, I, EffectiveJ).

skip_j_loop(TArr, N, I, J) ->
    if J < N andalso element(I + 1, TArr) > element(J + 1, TArr) ->
        skip_j_loop(TArr, N, I, J + 1);
    true ->
        J
    end.