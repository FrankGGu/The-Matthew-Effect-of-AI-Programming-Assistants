-module(solution).
-export([max_envelopes/1]).

max_envelopes(Envelopes) ->
    % 1. Sort envelopes:
    %    Primarily by width in ascending order.
    %    Secondarily by height in descending order if widths are equal.
    %    This ensures that for envelopes with the same width, only one can be part of the LIS.
    SortedEnvelopes = lists:sort(fun({W1, H1}, {W2, H2}) ->
                                     if W1 < W2 -> true;
                                        W1 > W2 -> false;
                                        true -> H1 > H2 % If widths are equal, sort heights descending
                                     end
                                 end, Envelopes),

    % 2. Extract heights from the sorted envelopes.
    Heights = [H || {_, H} <- SortedEnvelopes],

    % 3. Find the Longest Increasing Subsequence (LIS) of the heights.
    %    This is done using a gb_tree to maintain the "tails" of increasing subsequences,
    %    achieving an O(N log N) complexity.
    lis_gb_trees(Heights).

lis_gb_trees(Heights) ->
    % TailsTree stores the smallest tail of all increasing subsequences of length i+1.
    % The keys in the gb_tree are the tail values.
    % The size of the gb_tree will be the length of the LIS.
    FinalTree = lists:foldl(fun(H, TailsTree) ->
                                case gb_trees:is_empty(TailsTree) of
                                    true ->
                                        % If the tree is empty, just insert the first height.
                                        gb_trees:insert(H, true, TailsTree);
                                    false ->
                                        % Find the smallest key K in TailsTree such that K >= H.
                                        % gb_trees:next(Tree, Key) returns the smallest key strictly greater than Key.
                                        % By using H-1, we find the smallest key K' such that K' >= H.
                                        case gb_trees:next(TailsTree, H - 1) of
                                            {ok, K, _} when K >= H ->
                                                % Found a key K >= H. Replace K with H.
                                                % Delete K and then insert H.
                                                gb_trees:insert(H, true, gb_trees:delete(K, TailsTree));
                                            _ ->
                                                % No key K >= H found (meaning H is greater than all existing keys).
                                                % Append H to the sequence.
                                                gb_trees:insert(H, true, TailsTree)
                                        end
                                end
                            end, gb_trees:empty(), Heights),

    % The size of the final gb_tree is the length of the LIS.
    gb_trees:size(FinalTree).