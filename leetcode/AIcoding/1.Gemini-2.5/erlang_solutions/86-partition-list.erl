-module(solution).
-export([partition/2]).

partition(Head, X) ->
    % Step 1: Traverse the original linked list and separate values into two standard Erlang lists.
    % LessVals will contain values less than X, and GreaterVals will contain values greater than or equal to X.
    % The values are collected in reverse order, so we reverse them at the end of collection.
    {LessVals, GreaterVals} = collect_values(Head, X, [], []),

    % Step 2: Concatenate the two lists of values.
    % This preserves the relative order within each partition.
    CombinedVals = LessVals ++ GreaterVals,

    % Step 3: Convert the combined list of values back into a linked list format.
    list_to_linked_list(CombinedVals).

collect_values(null, _X, LessAcc, GreaterAcc) ->
    % Base case: End of the linked list. Reverse the accumulated lists.
    {lists:reverse(LessAcc), lists:reverse(GreaterAcc)};
collect_values({Val, Next}, X, LessAcc, GreaterAcc) when Val < X ->
    % If current node's value is less than X, add it to the LessAccumulator.
    collect_values(Next, X, [Val | LessAcc], GreaterAcc);
collect_values({Val, Next}, X, LessAcc, GreaterAcc) -> % Val >= X
    % If current node's value is greater than or equal to X, add it to the GreaterAccumulator.
    collect_values(Next, X, LessAcc, [Val | GreaterAcc]).

list_to_linked_list([]) ->
    % Base case: Empty list results in 'null' (end of linked list).
    null;
list_to_linked_list([H | T]) ->
    % Create a new node {H, NextNode} where NextNode is the linked list representation of the rest of the list.
    {H, list_to_linked_list(T)}.