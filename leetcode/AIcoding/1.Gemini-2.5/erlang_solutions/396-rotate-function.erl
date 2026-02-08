-module(solution).
-export([max_rotate_function/1]).

max_rotate_function(Nums) ->
    N = length(Nums),
    S = lists:sum(Nums),

    % Calculate F(0)
    % F(0) = 0*nums[0] + 1*nums[1] + ... + (n-1)*nums[n-1]
    F0 = lists:foldl(fun({Elem, Idx}, AccF) -> AccF + Elem * Idx end, 0, lists:zip(Nums, lists:seq(0, N-1))),

    % The elements that are subtracted in the formula F(k) = F(k-1) + S - N * nums[n-k]
    % are nums[n-1], nums[n-2], ..., nums[0].
    % This sequence corresponds to the original list in reverse order.
    ReversedNums = lists:reverse(Nums),

    % max_rotate_function_iter(RemainingReversedNums, CurrentF_value, MaxF_found_so_far, Sum_S, Length_N)
    % CurrentF_value initially holds F(0).
    % MaxF_found_so_far initially holds F(0).
    max_rotate_function_iter(ReversedNums, F0, F0, S, N).

max_rotate_function_iter([], _CurrentF, MaxF, _S, _N) ->
    MaxF;

max_rotate_function_iter([H|T], CurrentF, MaxF, S, N) ->
    % The current 'H' is nums[n-k] for the rotation 'k' we are about to calculate.
    % For the first call, H is nums[n-1], which is used to calculate F(1) from F(0).
    % The formula is F(k) = F(k-1) + S - N * nums[n-k]
    NextF = CurrentF + S - N * H,

    % Update the maximum F value found so far
    NextMaxF = max(MaxF, NextF),

    % Continue with the rest of the reversed list, the newly calculated F value,
    % and the updated maximum F value.
    max_rotate_function_iter(T, NextF, NextMaxF, S, N).