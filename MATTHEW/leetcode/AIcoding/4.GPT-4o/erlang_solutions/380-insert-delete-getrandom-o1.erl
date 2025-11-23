%% RandomizedSet class implementation

%% Define record for RandomizedSet
-record(randomized_set, {values = [], value_map = #{}}).

-spec randomized_set_init() -> any().
randomized_set_init() ->
    #randomized_set{values = [], value_map = #{}}, 
    % This initializes the set with an empty list and map.

-spec randomized_set_insert(Val :: integer(), Set :: #randomized_set{}) -> {boolean(), #randomized_set{}}.
randomized_set_insert(Val, #randomized_set{values = Vals, value_map = Map} = Set) ->
    case maps:find(Val, Map) of
        {ok, _} -> {false, Set}; % If value already exists, return false
        error -> 
            NewVals = Vals ++ [Val], % Append value to list
            NewMap = maps:put(Val, length(NewVals) - 1, Map), % Add value to map with its index
            {true, #randomized_set{values = NewVals, value_map = NewMap}}
    end.

-spec randomized_set_remove(Val :: integer(), Set :: #randomized_set{}) -> {boolean(), #randomized_set{}}.
randomized_set_remove(Val, #randomized_set{values = Vals, value_map = Map} = Set) ->
    case maps:find(Val, Map) of
        {ok, Index} ->
            LastVal = lists:last(Vals), % Get the last element in the list
            NewVals = lists:sublist(Vals, 1, Index) ++ tl(lists:sublist(Vals, Index + 1, length(Vals))),
            NewMap = maps:remove(Val, Map),
            % Swap last value with the removed one to keep O(1) time complexity
            NewMap1 = maps:put(LastVal, Index, NewMap),
            {true, #randomized_set{values = NewVals, value_map = NewMap1}};
        error -> {false, Set} % If value does not exist, return false
    end.

-spec randomized_set_get_random(Set :: #randomized_set{}) -> integer().
randomized_set_get_random(#randomized_set{values = Vals, _} = Set) ->
    RandomIndex = rand:uniform(length(Vals)) - 1, % Get a random index
    lists:nth(RandomIndex + 1, Vals).
