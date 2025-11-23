%% Define the structure for RandomizedCollection
-record(randomized_collection, {values = [], indices = #{} }).

%% Initializes the empty RandomizedCollection object
-spec randomized_collection_init() -> #randomized_collection{}.
randomized_collection_init() -> 
    #randomized_collection{values = [], indices = #{} }.

%% Inserts an item into the collection
-spec randomized_collection_insert(#randomized_collection{}, integer()) -> {boolean(), #randomized_collection{}}.
randomized_collection_insert(#randomized_collection{values = Values, indices = Indices} = Collection, Val) ->
    case lists:member(Val, Values) of
        true -> 
            {false, Collection};
        false ->
            NewValues = [Val | Values],
            NewIndices = maps:update_with(Val, fun(X) -> X + 1 end, 1, Indices),
            {true, #randomized_collection{values = NewValues, indices = NewIndices}}
    end.

%% Removes an item from the collection
-spec randomized_collection_remove(#randomized_collection{}, integer()) -> {boolean(), #randomized_collection{}}.
randomized_collection_remove(#randomized_collection{values = Values, indices = Indices} = Collection, Val) ->
    case lists:member(Val, Values) of
        true ->
            NewValues = tl(lists:splitwhile(fun(X) -> X /= Val end, Values)),
            NewIndices = maps:update_with(Val, fun(X) -> X - 1 end, Indices),
            {true, #randomized_collection{values = NewValues, indices = NewIndices}};
        false ->
            {false, Collection}
    end.

%% Returns a random element from the collection
-spec randomized_collection_get_random(#randomized_collection{}) -> integer().
randomized_collection_get_random(#randomized_collection{values = Values}) ->
    random:uniform(length(Values)) % Return a random element from the list
