-module(solution).
-export([take_gifts/2]).

take_gifts(Piles, K) ->
    % Step 1: Initialize a gb_trees as a max-heap.
    % Keys are of the form {-Value, UniqueId} to allow for duplicate pile sizes
    % and to use gb_trees:smallest/1 to efficiently retrieve the largest original value.
    % Values stored in the tree are the actual pile sizes.
    % We use a counter to generate unique IDs for the keys.
    {InitialTree, _} = lists:foldl(
        fun(Pile, {Tree, IdCounter}) ->
            NewTree = gb_trees:insert({-Pile, IdCounter}, Pile, Tree),
            {NewTree, IdCounter + 1}
        end,
        {gb_trees:empty(), 0}, % Initial accumulator: {empty_tree, starting_id_counter}
        Piles
    ),

    % Step 2: Perform K operations
    FinalTree = perform_operations(InitialTree, K),

    % Step 3: Sum all remaining gifts in the piles
    Sum = gb_trees:fold(fun(_Key, Value, Acc) -> Acc + Value end, 0, FinalTree),
    Sum.

perform_operations(Tree, 0) ->
    Tree;
perform_operations(Tree, K) ->
    % Get the largest element from the tree.
    % gb_trees:smallest/1 returns {{Key, Value}, ValueStoredInTree}.
    % Here, Key is {-OldValue, Id}, and ValueStoredInTree is OldValue.
    {{-OldValue, Id}, OldValue} = gb_trees:smallest(Tree),

    % Remove the largest element
    Tree1 = gb_trees:delete({-OldValue, Id}, Tree),

    % Calculate the new value for the pile
    NewValue = trunc(math:sqrt(OldValue)), % trunc for positive numbers is equivalent to floor

    % Insert the new value back into the tree.
    % We reuse the 'Id' to ensure uniqueness of the key {-NewValue, Id} within the tree.
    % Since {-OldValue, Id} was just deleted, {-NewValue, Id} will be a unique key.
    Tree2 = gb_trees:insert({-NewValue, Id}, NewValue, Tree1),

    % Recurse for the remaining K-1 operations
    perform_operations(Tree2, K - 1).