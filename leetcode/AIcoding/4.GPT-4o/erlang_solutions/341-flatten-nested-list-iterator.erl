%% Definition for NestedInteger.
%% -record(nested_integer, {val = 0 :: integer(), nested_list = [] :: list()}).

%% Initialize the NestedIterator with the nested list.
%% -spec init_nested_iterator(NestedList :: [#nested_integer{}]) -> {ok, list()}.
init_nested_iterator(NestedList) ->
    lists:reverse(flatten_list(NestedList)).

%% Flatten the list of nested integers recursively.
%% -spec flatten_list(NestedList :: [#nested_integer{}]) -> list().
flatten_list([]) -> [];
flatten_list([#nested_integer{val = Val, nested_list = []} | Tail]) -> [Val | flatten_list(Tail)];
flatten_list([#nested_integer{nested_list = NestedList} | Tail]) -> flatten_list(NestedList) ++ flatten_list(Tail);
flatten_list([#nested_integer{val = Val, nested_list = []} | Tail]) -> [Val | flatten_list(Tail)].

%% Check if there are more elements in the flattened list.
%% -spec has_next(State :: list()) -> boolean().
has_next([]) -> false;
has_next(_) -> true.

%% Get the next element in the flattened list.
%% -spec next(State :: list()) -> integer().
next([Head | Tail]) -> {Head, Tail}.
