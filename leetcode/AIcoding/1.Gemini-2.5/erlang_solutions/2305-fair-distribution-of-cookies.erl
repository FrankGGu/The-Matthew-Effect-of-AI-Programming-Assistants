-module(solution).
-export([fair_distribution/2]).

fair_distribution(Cookies, K) ->
    N = length(Cookies),
    CookiesArray = array:from_list(Cookies), % Convert cookies list to array for O(1) access
    ChildrenBags = lists:duplicate(K, 0), % Initialize K children with 0 cookies
    % Initial call to solve:
    % CookiesArray: The cookies as an array
    % K: Number of children
    % N: Total number of cookies
    % CookieIdx: Current cookie index being distributed (starts from 0)
    % ChildrenBags: List of current cookie sums for each child
    % MaxBagVal: Maximum cookie sum among children in the current distribution (used for pruning)
    % MinSoFar: The minimum unfairness found so far across all explored branches (used for pruning)
    solve(CookiesArray, K, N, 0, ChildrenBags, 0, 1000000000). % 10^9 is a sufficiently large initial value

solve(CookiesArray, K, N, CookieIdx, ChildrenBags, MaxBagVal, MinSoFar) when CookieIdx == N ->
    % Base case: All cookies have been distributed
    % The unfairness for this complete distribution is MaxBagVal
    MaxBagVal;

solve(CookiesArray, K, N, CookieIdx, ChildrenBags, MaxBagVal, MinSoFar) when CookieIdx < N ->
    % Recursive step: Distribute the current cookie
    CookieVal = array:get(CookieIdx, CookiesArray),

    % Use lists:foldl to iterate through each child and try assigning the current cookie
    % AccMin: Accumulates the minimum unfairness found for this branch (initialized with MinSoFar)
    % AssignedToEmptyThisCookie: A boolean flag for symmetric pruning.
    %   True if the current cookie has already been assigned to an empty child bag at this level.
    %   Used to avoid redundant computations for symmetric assignments (e.g., [C,0] vs [0,C]).
    {FinalMinUnfairness, _} = lists:foldl(fun(ChildIdx, {AccMin, AssignedToEmptyThisCookie}) ->
        ChildBagVal = lists:nth(ChildIdx + 1, ChildrenBags), % Get current sum for this child

        % Symmetric pruning: If this child's bag was empty (0 cookies) and we've already
        % assigned the current cookie to another empty bag in a previous iteration,
        % then this assignment is symmetric and can be skipped.
        ShouldSkip = (ChildBagVal == 0) andalso AssignedToEmptyThisCookie,

        if ShouldSkip ->
            {AccMin, AssignedToEmptyThisCookie}; % Skip this branch, return current accumulator
        else
            NewChildBagVal = ChildBagVal + CookieVal, % Add current cookie to child's bag

            NewMaxBagVal = max(MaxBagVal, NewChildBagVal), % Update the max unfairness for this distribution

            % Pruning: If the current distribution's unfairness (NewMaxBagVal) is already
            % greater than or equal to the best unfairness found so far (AccMin),
            % then this path cannot lead to a better solution, so prune.
            if NewMaxBagVal >= AccMin ->
                {AccMin, AssignedToEmptyThisCookie}; % Prune, return current accumulator
            else
                % Create new ChildrenBags list with the updated child's sum
                NewChildrenBags = lists:replace_at(ChildIdx + 1, NewChildBagVal, ChildrenBags),

                % Update the AssignedToEmptyThisCookie flag for subsequent iterations
                NextAssignedToEmptyThisCookie = AssignedToEmptyThisCookie orelse (ChildBagVal == 0),

                % Recursively call solve for the next cookie
                BranchResult = solve(CookiesArray, K, N, CookieIdx + 1, NewChildrenBags, NewMaxBagVal, AccMin),

                % Update AccMin with the minimum of current AccMin and the result from this branch
                {min(AccMin, BranchResult), NextAssignedToEmptyThisCookie}
            end
        end
    end, {MinSoFar, false}, lists:seq(0, K-1)), % Initial foldl state: {MinSoFar, false}
    FinalMinUnfairness. % Return the minimum unfairness found for this cookie distribution level