-module(solution).
-export([is_possible/1]).

is_possible(Target) ->
    N = length(Target),
    Sum = lists:sum(Target),

    % Initialize a gb_trees as a frequency map (value -> count) to act as a max-priority queue.
    % gb_trees:update_counter(Key, Increment, Tree) is used to manage counts.
    Pq = lists:foldl(fun(V, Acc) -> gb_trees:update_counter(V, 1, Acc) end, gb_trees:empty(), Target),

    solve(Pq, Sum, N).

solve(Pq, Sum, N) ->
    % Base case: If the sum equals N, it means all elements are 1.
    % This is the target state, so it's possible.
    case Sum of
        N -> true;
        _ ->
            % Get the largest element from the priority queue.
            % gb_trees:largest/1 returns {Key, Value} where Key is the largest element.
            {Max, _} = gb_trees:largest(Pq),

            % Calculate the sum of all elements except the largest one.
            RestSum = Sum - Max,

            % Check for impossible conditions
            if
                % If RestSum is 0, it means N=1.
                % If N=1 and Max > 1 (e.g., [2]), it's impossible to reach [1].
                % If N=1 and Max = 1, it would be caught by Sum = N condition.
                RestSum =:= 0 -> false;

                % If Max is less than or equal to RestSum, it's an impossible state.
                % 1. If Max = RestSum: The previous value for Max would be 0 (Max - RestSum), which is invalid.
                %    (e.g., [3, 3] -> S=6, M=3, R=3. M=R -> false)
                % 2. If Max < RestSum: This implies that Max was not the element that was generated in the last step,
                %    as the generated element must be the largest. This also implies an invalid state.
                %    (e.g., [2, 1, 1] -> S=4, M=2, R=2. M=R -> false)
                %    (e.g., [1, 5, 2] -> S=8, M=5, R=3. M>R. NewMax = (5-1)rem3+1 = 2. [1,2,2]. S=5, M=2, R=3. M<R -> false)
                Max =< RestSum -> false;

                % If conditions above are not met, proceed with the reverse operation.
                true ->
                    % The previous value of Max is calculated using the modulo operation for optimization.
                    % If Max was `X` and RestSum was `R`, and `X` was replaced by `X + R`, then
                    % the current Max is `X + R`. We want to find `X`.
                    % In reverse, `Max_prev = Max - RestSum`.
                    % If Max is much larger than RestSum, Max_prev will still be the largest.
                    % We can effectively apply `Max = Max - RestSum` multiple times.
                    % The new value of Max will be `(Max - 1) rem RestSum + 1`.
                    % This ensures the new value is positive and the smallest possible after reductions.
                    NewMax = (Max - 1) rem RestSum + 1,

                    % Update the frequency map (priority queue).
                    % Decrease count of 'Max' by 1. If count becomes 0, gb_trees:update_counter removes it.
                    Pq1 = gb_trees:update_counter(Max, -1, Pq),
                    % Increase count of 'NewMax' by 1. If 'NewMax' not present, it's added with count 1.
                    Pq2 = gb_trees:update_counter(NewMax, 1, Pq1),

                    % Update the total sum.
                    NewSum = Sum - Max + NewMax,

                    % Recurse with the updated state.
                    solve(Pq2, NewSum, N)
            end
    end.