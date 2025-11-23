-spec put_marbles_in_bags(Weights :: [integer()], K :: integer()) -> [integer()].
put_marbles_in_bags(Weights, K) ->
    % Calculate all possible split costs: weights[i] + weights[i+1]
    Costs = calculate_costs(Weights),

    % Sort the costs to easily find min and max sums
    SortedCosts = lists:sort(Costs),

    % The number of splits required is K-1.
    % If K=1, K-1=0, lists:sublist([], 0) returns [], lists:sum([]) returns 0. This is correct.

    % Minimum cost: sum of the K-1 smallest costs
    MinCost = lists:sum(lists:sublist(SortedCosts, K - 1)),

    % Maximum cost: sum of the K-1 largest costs
    % We can get the largest K-1 costs by reversing the sorted list and taking the first K-1 elements.
    MaxCost = lists:sum(lists:sublist(lists:reverse(SortedCosts), K - 1)),

    [MinCost, MaxCost].

calculate_costs([_]) -> 
    []; % Base case: single element, no adjacent pairs
calculate_costs([H1, H2 | T]) ->
    [H1 + H2 | calculate_costs([H2 | T])].