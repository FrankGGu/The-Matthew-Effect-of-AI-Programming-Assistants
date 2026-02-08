-record(list_node, {val, next}).
-record(tree_node, {val, left, right}).

-export([sortedListToBST/1]).

sortedListToBST(Head) ->
    Len = list_length(Head),
    {Tree, _NewHead} = build_bst_recursive(Head, 0, Len - 1),
    Tree.

list_length(nil) -> 0;
list_length(#list_node{next := Next}) -> 1 + list_length(Next).

build_bst_recursive(CurrentListPtr, Low, High) ->
    if Low > High ->
        {nil, CurrentListPtr};
    else
        Mid = Low + (High - Low) div 2,

        {LeftTree, ListAfterLeft} = build_bst_recursive(CurrentListPtr, Low, Mid - 1),

        RootVal = ListAfterLeft#list_node.val,
        ListAfterRoot = ListAfterLeft#list_node.next,

        {RightTree, ListAfterRight} = build_bst_recursive(ListAfterRoot, Mid + 1, High),

        RootNode = #tree_node{val = RootVal, left = LeftTree, right = RightTree},

        {RootNode, ListAfterRight}
    end.