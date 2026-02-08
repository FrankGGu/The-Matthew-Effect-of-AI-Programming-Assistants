-module(solution).
-export([split_array/2]).

%% Binary search helper function.
-spec can_split([integer()], integer(), integer()) -> boolean().
can_split(_, _, 0) -> false;
can_split([], _, _) -> true;
can_split([H | T], MaxSum, K) when H > MaxSum -> false;
can_split([H | T], MaxSum, K) when H + sum_sublist([H | T]) > MaxSum -> can_split(T, MaxSum, K - 1);
can_split([H | T], MaxSum, K) -> can_split(T, MaxSum, K).

%% Sum of a sublist function.
-spec sum_sublist([integer()]) -> integer().
sum_sublist([]) -> 0;
sum_sublist([H | T]) -> H + sum_sublist(T).

%% Main function to split array.
-spec split_array([integer()], integer()) -> integer().
split_array(Nums, K) ->
    %% The lower bound is the maximum element in the list, and the upper bound is the sum of all elements.
    Lower = lists:max(Nums),
    Upper = lists:sum(Nums),
    %% Perform binary search to minimize the largest sum.
    binary_search(Nums, Lower, Upper, K).

%% Perform binary search for the minimized largest sum.
-spec binary_search([integer()], integer(), integer(), integer()) -> integer().
binary_search(Nums, Lower, Upper, K) when Lower < Upper ->
    Mid = (Lower + Upper) div 2,
    %% Check if we can split the array with the largest sum of Mid.
    case can_split(Nums, Mid, K) of
        true -> binary_search(Nums, Lower, Mid, K);  % Try to reduce the max sum
        false -> binary_search(Nums, Mid + 1, Upper, K)  % Increase the max sum
    end;
binary_search(_, Result, _, _) -> Result.
