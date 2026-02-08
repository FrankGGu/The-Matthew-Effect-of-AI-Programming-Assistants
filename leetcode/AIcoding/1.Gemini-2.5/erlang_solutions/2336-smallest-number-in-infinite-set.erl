-module(smallest_infinite_set).
-export([new/0, pop_smallest/1, add_back/2]).

new() ->
    %% Initialize with 1 as the first smallest available number
    %% and an empty gb_tree for numbers added back.
    {1, gb_trees:empty()}.

pop_smallest({NextSmallest, AddedBackNums}) ->
    if gb_trees:is_empty(AddedBackNums) ->
        %% If there are no numbers that were added back,
        %% the smallest available number is NextSmallest.
        Val = NextSmallest,
        %% Increment NextSmallest for the next pop operation.
        NewState = {NextSmallest + 1, AddedBackNums},
        {Val, NewState};
    true ->
        %% If there are numbers in AddedBackNums, the smallest among them
        %% is the true smallest number currently in the set.
        {Val, _} = gb_trees:smallest(AddedBackNums),
        %% Remove this number from the AddedBackNums set.
        NewAddedBackNums = gb_trees:delete(Val, AddedBackNums),
        %% NextSmallest remains unchanged as we took a number from the
        %% 'added back' pool, not from the 'never popped' infinite sequence.
        NewState = {NextSmallest, NewAddedBackNums},
        {Val, NewState}
    end.

add_back({NextSmallest, AddedBackNums}, Num) ->
    if Num < NextSmallest ->
        %% A number can only be added back if it's smaller than NextSmallest.
        %% This implies it must have been popped previously.
        %% We also need to ensure it's not already present in the AddedBackNums set.
        if not gb_trees:is_defined(Num, AddedBackNums) ->
            %% Add Num to the gb_tree (using Num as both key and value).
            NewAddedBackNums = gb_trees:insert(Num, Num, AddedBackNums),
            {NextSmallest, NewAddedBackNums};
        true ->
            %% Num is already in AddedBackNums, so do nothing.
            {NextSmallest, AddedBackNums}
        end;
    true ->
        %% If Num >= NextSmallest, it means:
        %% 1. Num is the current NextSmallest (it's implicitly available).
        %% 2. Num is greater than NextSmallest (it's also implicitly available
        %%    in the infinite sequence and hasn't been popped yet).
        %% In both cases, there's no need to add it to the explicit
        %% AddedBackNums set, as it's already considered "in" the set.
        %% Do nothing.
        {NextSmallest, AddedBackNums}
    end.