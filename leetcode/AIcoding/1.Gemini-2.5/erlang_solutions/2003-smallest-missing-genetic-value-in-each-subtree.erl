-module(solution).
-export([smallestMissingValueSubtree/2]).

build_adj(Parents, N) ->
    lists:foldl(
        fun(I, Acc) ->
            Parent = element(I+1, Parents), % Erlang list/tuple indexing is 1-based, Parents is 0-based
            case Parent of
                -1 -> Acc; % Root node (0) has parent -1, no children for -1
                _ ->
                    Children = maps:get(Parent, Acc, []),
                    maps:put(Parent, [I | Children], Acc)
            end
        end,
        maps:new(),
        lists:seq(0, N-1) % Iterate through all nodes 0 to N-1
    ).

find_smallest_missing_from(Set, StartVal) ->
    find_smallest_missing_loop(Set, StartVal).

find_smallest_missing_loop(Set, K) ->
    case sets:is_element(K, Set) of
        true -> find_smallest_missing_loop(Set, K + 1);
        false -> K
    end.

dfs(U, Adj, Nums, N, Answers) ->
    Children = maps:get(U, Adj, []), % Get children of node U

    NodeVal = element(U+1, Nums), % Genetic value of current node U

    % Initial set and smallest missing for current node U
    % Optimization: only add values <= N+1. Values > N+1 cannot be the smallest missing positive <= N+1.
    CurrentSet = case NodeVal =< N+1 of
                     true -> sets:add(NodeVal, sets:new());
                     false -> sets:new()
                 end,

    % The smallest missing for a single node's subtree is 1 unless its value is 1.
    CurrentSmallestMissing = case NodeVal of
                                 1 -> 2; % If node U has value 1, then 1 is not missing, so smallest missing is at least 2
                                 _ -> 1  % Otherwise, 1 is missing
                             end,

    % Fold over children to recursively process their subtrees and merge their sets
    {FinalSet, SmallestMissingAfterChildren, FinalAnswers} =
        lists:foldl(
            fun(V, {AccSet, AccSmallestMissing, AccAnswers}) ->
                % Recursively call DFS for child V
                {ChildSet, ChildSmallestMissing, UpdatedAnswers} = dfs(V, Adj, Nums, N, AccAnswers),

                % Merge sets using small-to-large strategy for sets:union efficiency
                % sets:union is O(Size1 + Size2). By always merging smaller into larger, total union cost is O(N log N).
                MergedSet = if sets:size(AccSet) < sets:size(ChildSet) ->
                                sets:union(AccSet, ChildSet);
                            else
                                sets:union(ChildSet, AccSet)
                            end,

                % Calculate the new smallest missing for the combined (AccSet + ChildSet)
                % Start checking from the minimum of the two current smallest_missing values.
                % This ensures that the total increments for K in find_smallest_missing_from is O(N).
                NewSmallestMissing = find_smallest_missing_from(MergedSet, min(AccSmallestMissing, ChildSmallestMissing)),

                {MergedSet, NewSmallestMissing, UpdatedAnswers}
            end,
            {CurrentSet, CurrentSmallestMissing, Answers}, % Initial accumulator for fold
            Children
        ),

    % Store the result for node U in the answers array
    UpdatedAnswers = array:set(U+1, SmallestMissingAfterChildren, FinalAnswers),

    {FinalSet, SmallestMissingAfterChildren, UpdatedAnswers}.

smallestMissingValueSubtree(Parents, Nums) ->
    N = length(Parents),
    Adj = build_adj(Parents, N),

    % Initialize answers array. Erlang arrays are 1-indexed, so N elements means indices 1 to N.
    % Default value 0 will be overwritten.
    InitialAnswers = array:new(N, {default, 0}),

    % Start DFS from the root node (node 0)
    % The problem guarantees node 0 is the root (parents[0] == -1).
    {_FinalSet, _FinalSmallestMissing, ResultAnswers} = dfs(0, Adj, Nums, N, InitialAnswers),

    % Convert the Erlang array to a list for the final output
    array:to_list(ResultAnswers).