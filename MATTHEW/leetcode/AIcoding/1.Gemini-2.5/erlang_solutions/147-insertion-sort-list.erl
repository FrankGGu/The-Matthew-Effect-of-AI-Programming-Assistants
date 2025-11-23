-module(solution).
-export([insertion_sort_list/1]).

-record(list_node, {val, next = null}).

insertion_sort_list(Head) ->
    % Create a dummy node to simplify handling the head of the sorted list.
    % The actual sorted list will start from Dummy#list_node.next.
    Dummy = #list_node{val = 0, next = null},
    insertion_sort_list_recursive(Head, Dummy).

insertion_sort_list_recursive(null, Dummy) ->
    % All nodes from the original list have been processed and inserted.
    % Return the head of the sorted list (skipping the dummy node).
    Dummy#list_node.next;
insertion_sort_list_recursive(CurrentUnsorted, Dummy) ->
    % Store the next node from the unsorted list before detaching CurrentUnsorted.
    NextUnsorted = CurrentUnsorted#list_node.next,

    % Detach CurrentUnsorted from the unsorted list.
    % This is important to ensure we're only moving one node at a time.
    CurrentUnsorted#list_node.next = null,

    % Find the correct insertion point in the already sorted list (which starts from Dummy).
    % 'Prev' will point to the node *before* where CurrentUnsorted should be inserted.
    Prev = find_insertion_prev(Dummy, Dummy#list_node.next, CurrentUnsorted),

    % Insert CurrentUnsorted into the sorted list after 'Prev'.
    CurrentUnsorted#list_node.next = Prev#list_node.next,
    Prev#list_node.next = CurrentUnsorted,

    % Continue the process with the next node from the original unsorted list.
    insertion_sort_list_recursive(NextUnsorted, Dummy).

find_insertion_prev(Prev, CurrentSorted, NodeToInsert) ->
    case CurrentSorted of
        null ->
            % Reached the end of the sorted list, NodeToInsert should be appended.
            Prev;
        #list_node{val = Val} when Val >= NodeToInsert#list_node.val ->
            % Found a node (CurrentSorted) whose value is greater than or equal to NodeToInsert's value.
            % This means NodeToInsert should be inserted *before* CurrentSorted,
            % which is effectively *after* Prev.
            Prev;
        #list_node{next = Next} ->
            % NodeToInsert's value is greater than CurrentSorted's value,
            % so continue searching further in the sorted list.
            find_insertion_prev(CurrentSorted, Next, NodeToInsert)
    end.