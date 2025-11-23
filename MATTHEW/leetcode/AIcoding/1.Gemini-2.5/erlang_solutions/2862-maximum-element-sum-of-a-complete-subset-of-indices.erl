-module(solution).
-export([max_sum_complete_subset/1]).

-spec max_sum_complete_subset(Nums :: [integer()]) -> integer().
max_sum_complete_subset(Nums) ->
    % Convert the input list to an array for O(1) element access.
    % LeetCode's Erlang environment usually provides lists, and direct list
    % access (e.g., lists:nth) would be O(N) per access, leading to O(N^2) overall.
    NumsArray = array:from_list(Nums),
    N = array:size(NumsArray), % N is the number of elements (0 to N-1)

    % Start the main loop.
    % I: current 1-based index (from 1 to N)
    % N: total number of elements
    % NumsArray: the array for O(1) access
    % SumsMap: a map to store sums for each square-free part (Key: square-free part, Value: current sum)
    % MaxSum: the maximum sum found so far
    max_sum_loop(1, N, NumsArray, #{}, 0).

-spec max_sum_loop(I :: integer(), N :: integer(), NumsArray :: array:array(integer()), SumsMap :: map(), MaxSum :: integer()) -> integer().
max_sum_loop(I, N, NumsArray, SumsMap, MaxSum) when I =< N ->
    % Get the value for the current 1-based index I from the 0-indexed array.
    Val = array:get(I - 1, NumsArray),

    % Calculate the square-free part of the current index I.
    SqFreePart = get_square_free_part(I),

    % Retrieve the current sum for this square-free part from the map.
    % If not present, default to 0.
    CurrentSum = maps:get(SqFreePart, SumsMap, 0),

    % Add the current value to the sum.
    NewSum = CurrentSum + Val,

    % Update the map with the new sum for this square-free part.
    NewSumsMap = maps:put(SqFreePart, NewSum, SumsMap),

    % Update the overall maximum sum found so far.
    NewMaxSum = max(MaxSum, NewSum),

    % Recurse to process the next index.
    max_sum_loop(I + 1, N, NumsArray, NewSumsMap, NewMaxSum);
max_sum_loop(_I, _N, _NumsArray, _SumsMap, MaxSum) ->
    % Base case: all indices have been processed. Return the final maximum sum.
    MaxSum.

-spec get_square_free_part(N :: integer()) -> integer().
get_square_free_part(N) ->
    square_free_part_recursive(N, 2).

-spec square_free_part_recursive(CurrentN :: integer(), P :: integer()) -> integer().
square_free_part_recursive(CurrentN, P) when P*P =< CurrentN ->
    % If CurrentN is divisible by P*P, divide it by P*P and re-check with the same P.
    % This handles cases like 72 = 2^3 * 3^2, where P=2, CurrentN becomes 18, then P=3, CurrentN becomes 2.
    if CurrentN rem (P*P) == 0 ->
        square_free_part_recursive(CurrentN div (P*P), P);
    % Otherwise, increment P and continue checking for the next potential factor.
    true ->
        square_free_part_recursive(CurrentN, P + 1)
    end;
square_free_part_recursive(CurrentN, _P) ->
    % Base case: P*P is greater than CurrentN, meaning no more square factors can be removed.
    % CurrentN is now the square-free part.
    CurrentN.