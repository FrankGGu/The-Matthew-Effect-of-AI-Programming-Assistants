%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

%% Solution Initialization
-spec solution_init_(Head :: #list_node{} | null) -> any().
solution_init_(Head) ->
    store_head(Head).

%% Store the head globally for random access
store_head(Head) -> 
    %% Using global state to store the list head
    erlang:put(head, Head).

%% Get a random value from the linked list
-spec solution_get_random() -> integer().
solution_get_random() ->
    Head = erlang:get(head),
    get_random_from_list(Head, 1, 0).

%% Helper function to traverse the list and pick a random node
get_random_from_list(null, _, _) -> 0;  %% Return 0 if list is empty
get_random_from_list(#list_node{val = Val, next = Next}, Index, Chosen) ->
    Random = random:uniform(Index),
    NewChosen = if Random =:= Index -> Val; true -> Chosen end,
    get_random_from_list(Next, Index + 1, NewChosen).
