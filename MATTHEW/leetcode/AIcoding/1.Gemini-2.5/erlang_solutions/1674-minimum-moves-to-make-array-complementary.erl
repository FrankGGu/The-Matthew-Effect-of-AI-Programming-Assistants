-module(solution).
-export([min_moves_to_make_array_complementary/2]).

-include_lib("array/include/array.hrl"). % Required for array module

min_moves_to_make_array_complementary(Nums, Limit) ->
    N = length(Nums),
    MaxPossibleSum = 2 * Limit,

    % Initialize a difference array.
    % The array will store changes in the number of moves needed for each target sum.
    % Indices correspond to target sums T, from 2 up to MaxPossibleSum.
    % We need indices up to MaxPossibleSum + 1 for the sweep line technique.
    % So, array size is MaxPossibleSum + 2 (for 0-indexed array, indices 0 to MaxPossibleSum + 1).
    % Indices 0 and 1 will be unused.
    DiffArray = array:new(MaxPossibleSum + 2, 0),

    % Process each pair (nums[i], nums[n - 1 - i])
    UpdatedDiffArray = lists:foldl(
        fun(I, CurrentDiffArray) ->
            % Get elements for the current pair.
            % Erlang lists are 1-indexed. I goes from 0 to N/2 - 1.
            A = lists:nth(I + 1, Nums),
            B = lists:nth(N - I, Nums),

            % Ensure X <= Y for consistent logic
            X = min(A, B),
            Y = max(A, B),

            % Apply sweep line updates based on cost ranges for the pair (X, Y):
            % 1. All sums initially cost 2 moves.
            %    Increment at the start of the range [2, MaxPossibleSum].
            Array1 = array:set(2, array:get(2, CurrentDiffArray) + 2, CurrentDiffArray),

            % 2. Sums in [X+1, Y+Limit] cost 1 move (1 less than 2).
            %    Decrement at X+1.
            Array2 = array:set(X + 1, array:get(X + 1, Array1) - 1, Array1),

            % 3. Sum X+Y costs 0 moves (1 less than 1, or 2 less than 2).
            %    Decrement at X+Y.
            Array3 = array:set(X + Y, array:get(X + Y, Array2) - 1, Array2),

            % 4. Sums in [X+Y+1, Y+Limit] cost 1 move again (1 more than 0, or 1 less than 2).
            %    Increment at X+Y+1.
            Array4 = array:set(X + Y + 1, array:get(X + Y + 1, Array3) + 1, Array3),

            % 5. Sums in [Y+Limit+1, MaxPossibleSum] cost 2 moves again (1 more than 1).
            %    Increment at Y+Limit+1.
            Array5 = array:set(Y + Limit + 1, array:get(Y + Limit + 1, Array4) + 1, Array4),
            Array5
        end,
        DiffArray,
        lists:seq(0, N div 2 - 1) % Iterate for I from 0 up to N/2 - 1
    ),

    % Calculate the minimum moves by iterating through possible target sums.
    % CurrentMoves tracks the total moves for the current target sum T.
    % MinMoves stores the minimum CurrentMoves found so far.
    calculate_min_moves(2, MaxPossibleSum, UpdatedDiffArray, 0, infinity).

calculate_min_moves(T, MaxSum, DiffArray, CurrentMoves, MinMoves) when T =< MaxSum ->
    % Add the delta for the current target sum T to CurrentMoves.
    Delta = array:get(T, DiffArray),
    NewCurrentMoves = CurrentMoves + Delta,
    % Update MinMoves if a smaller value is found.
    NewMinMoves = min(MinMoves, NewCurrentMoves),
    % Recurse for the next target sum.
    calculate_min_moves(T + 1, MaxSum, DiffArray, NewCurrentMoves, NewMinMoves);
calculate_min_moves(_T, _MaxSum, _DiffArray, _CurrentMoves, MinMoves) ->
    % Base case: all target sums processed, return the overall minimum.
    MinMoves.