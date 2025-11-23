-module(solution).
-export([mctFromLeafValues/1]).

mctFromLeafValues(Arr) ->
    % Sentinel value, larger than any possible leaf value (1 <= arr[i] <= 15).
    % Used to simplify stack logic, ensuring hd(Rest) is always valid and
    % to terminate pop_and_sum recursion when the stack is conceptually empty.
    Sentinel = 1000000000, 
    Stack = [Sentinel], 

    % Fold over the input array, maintaining the accumulated cost and the monotonic stack.
    {Cost, FinalStackWithSentinel} = lists:foldl(
        fun(X, {AccCost, CurrentStack}) ->
            % Process X against the current stack. Pop elements smaller than X.
            {NewAccCost, NewCurrentStack} = pop_and_sum(X, AccCost, CurrentStack),
            % Push X onto the stack.
            {NewAccCost, [X | NewCurrentStack]}
        end,
        {0, Stack}, % Initial accumulator: {cost, stack}
        Arr
    ),

    % After processing all elements in Arr, the stack will contain elements
    % in decreasing order, followed by the sentinel: [v_m, v_{m-1}, ..., v_1, Sentinel].
    % We need to sum products of adjacent elements: v_m*v_{m-1} + v_{m-1}*v_{m-2} + ... + v_2*v_1.
    % First, remove the sentinel from the stack for final processing.
    ActualStack = droplast(FinalStackWithSentinel),

    % Calculate the remaining cost from the elements left in the stack.
    FinalCost = final_stack_sum(ActualStack, Cost),
    FinalCost.

pop_and_sum(X, AccCost, CurrentStack) ->
    case CurrentStack of
        [Top | Rest] when Top < X ->
            % Top is smaller than X, so it must be combined with its neighbors.
            % The product is Top * min(LeftNeighbor, X).
            % LeftNeighbor is the element below Top, which is hd(Rest).
            % The sentinel ensures Rest is never empty, so hd(Rest) is always valid.
            {NewAccCost, NewerCurrentStack} = pop_and_sum(X, AccCost + Top * min_val(hd(Rest), X), Rest),
            {NewAccCost, NewerCurrentStack};
        _ ->
            % Top is >= X, or stack is effectively empty (only sentinel left).
            % No more elements need to be popped for X.
            {AccCost, CurrentStack}
    end.

min_val(A, B) ->
    if A < B -> A;
       true -> B
    end.

droplast(L) -> droplast(L, []).
droplast([_], Acc) -> lists:reverse(Acc); % Base case: single element list, reverse accumulator
droplast([H|T], Acc) -> droplast(T, [H|Acc]). % Recursive step

final_stack_sum([], AccCost) -> AccCost;
final_stack_sum([_SingleElement], AccCost) -> AccCost; % Only one element left, no more pairs to form.
final_stack_sum([Top1, Top2 | Rest], AccCost) ->
    % Top1 is the current top element, Top2 is the next element.
    % We combine Top1 and Top2. Top1 is effectively removed from the stack.
    % The product Top1 * Top2 is added to the total cost.
    % Recurse with Top2 as the new top of the conceptual stack.
    final_stack_sum([Top2 | Rest], AccCost + Top1 * Top2).