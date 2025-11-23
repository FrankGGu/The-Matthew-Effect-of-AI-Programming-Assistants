-module(find_elements).
-export([new/1, find/2]).

-record(find_elements_state, {values :: gb_set:set()}).

new(Root) ->
    Values = gb_set:new(),
    RecoveredValues = recover_tree(Root, 0, Values),
    #find_elements_state{values = RecoveredValues}.

recover_tree(null, _CurrentVal, AccSet) ->
    AccSet;
recover_tree(Node, CurrentVal, AccSet) ->
    NewSet = gb_set:add(CurrentVal, AccSet),
    LeftVal = 2 * CurrentVal + 1,
    RightVal = 2 * CurrentVal + 2,
    SetAfterLeft = recover_tree(Node#treenode.left, LeftVal, NewSet),
    recover_tree(Node#treenode.right, RightVal, SetAfterLeft).

find(#find_elements_state{values = Values}, Target) ->
    gb_set:is_member(Target, Values).