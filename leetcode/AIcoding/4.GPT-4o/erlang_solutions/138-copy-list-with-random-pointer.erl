%% Definition for singly-linked list with random pointer.
%% -record(node, {val = 0 :: integer(), next = null :: 'null' | #node{}, random = null :: 'null' | #node{}}).

-spec copy_random_list(Head :: #node{} | null) -> #node{} | null.
copy_random_list(Head) ->
    copy_random_list(Head, []).

copy_random_list(null, _) -> null;
copy_random_list(#node{val = Val, next = Next, random = Random}, Mapped) ->
    case lists:keyfind(Val, 1, Mapped) of
        false ->
            NewNode = #node{val = Val, next = null, random = null},
            NewNext = copy_random_list(Next, [{Val, NewNode} | Mapped]),
            NewRandom = find_random_node(Random, Mapped),
            NewNode2 = NewNode#node{random = NewRandom},
            NewNode2#node{next = NewNext};
        {_, CopyNode} ->
            NewNext = copy_random_list(Next, Mapped),
            CopyNode#node{next = NewNext}
    end.

-spec find_random_node(Random :: #node{} | null, Mapped :: list()) -> #node{} | null.
find_random_node(null, _) -> null;
find_random_node(#node{val = Val}, Mapped) ->
    case lists:keyfind(Val, 1, Mapped) of
        false -> null;
        {_, CopyNode} -> CopyNode
    end.
