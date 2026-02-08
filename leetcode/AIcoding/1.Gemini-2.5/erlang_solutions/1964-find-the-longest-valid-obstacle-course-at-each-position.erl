-module(solution).
-export([longest_obstacle_course/1]).

longest_obstacle_course(Obstacles) ->
    % State: {TailsMap, MaxLen, ResultsAcc}
    % TailsMap: gb_tree where keys are the smallest ending elements of Longest Non-Decreasing Subsequences (LNDS)
    %           and values are their corresponding lengths.
    %           For example, {1 => 1, 2 => 2, 4 => 3} means:
    %           - An LNDS of length 1 ends with 1.
    %           - An LNDS of length 2 ends with 2.
    %           - An LNDS of length 3 ends with 4.
    %           The keys in TailsMap are always strictly increasing.
    % MaxLen: The current maximum length of any LNDS found so far.
    % ResultsAcc: Accumulator for the results, built in reverse order.
    {_FinalTailsMap, _FinalMaxLen, ReversedResults} = lists:foldl(
        fun(Obstacle, {TailsMap, MaxLen, ResultsAcc}) ->
            CurrentLen = 0,
            NewTailsMap = gb_trees:empty(), % Placeholder, will be reassigned

            % Find the smallest key in TailsMap that is strictly greater than Obstacle.
            % This corresponds to finding the 'upper_bound' in a sorted array.
            case gb_trees:next(Obstacle, TailsMap) of
                none ->
                    % If no key is strictly greater than Obstacle, it means Obstacle
                    % is greater than or equal to all existing tail elements.
                    % It extends the longest LNDS found so far.
                    CurrentLen = MaxLen + 1,
                    NewTailsMap = gb_trees:insert(Obstacle, CurrentLen, TailsMap);
                {value, OldTail, OldLen} ->
                    % Obstacle replaces OldTail (the smallest element > Obstacle).
                    % The length of the LNDS ending with Obstacle will be OldLen,
                    % as it forms a new LNDS of the same length but with a smaller ending element,
                    % which is more favorable for future extensions.
                    CurrentLen = OldLen,
                    NewTailsMap = gb_trees:delete(OldTail, TailsMap),
                    NewTailsMap = gb_trees:insert(Obstacle, CurrentLen, NewTailsMap)
            end,

            % Update MaxLen if CurrentLen is greater, and add CurrentLen to results.
            {NewTailsMap, max(MaxLen, CurrentLen), [CurrentLen | ResultsAcc]}
        end,
        {gb_trees:empty(), 0, []}, % Initial state: empty tree, max length 0, empty results list
        Obstacles
    ),
    lists:reverse(ReversedResults). % Reverse the accumulated results to get the correct order