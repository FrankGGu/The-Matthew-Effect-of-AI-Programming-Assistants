-module(solution).
-export([next_greater_nodes/1]).

-record(node, {val, next}).

next_greater_nodes(List) ->
    LinkedList = create_linked_list(List),
    Values = extract_values(LinkedList),
    Length = length(Values),
    NextGreater = lists:duplicate(Length, 0),
    find_next_greater(Values, NextGreater, Length, 0, []),
    NextGreater.

create_linked_list([]) -> none;
create_linked_list([H | T]) ->
    Node = #node{val = H, next = create_linked_list(T)},
    Node.

extract_values(Node) ->
    case Node of
        none -> [];
        #node{val = Val, next = Next} -> [Val | extract_values(Next)]
    end.

find_next_greater([], NextGreater, _, _, _) -> NextGreater;
find_next_greater([H | T], NextGreater, Length, Index, Stack) ->
    case Stack of
        [] ->
            find_next_greater(T, NextGreater, Length, Index + 1, [Index]);
        [Top | _] when H > lists:nth(Top + 1, NextGreater) ->
            NewNextGreater = lists:replace_element(Top + 1, H, NextGreater),
            find_next_greater([H | T], NewNextGreater, Length, Index, tl(Stack));
        _ ->
            find_next_greater(T, NextGreater, Length, Index + 1, [Index | Stack])
    end.