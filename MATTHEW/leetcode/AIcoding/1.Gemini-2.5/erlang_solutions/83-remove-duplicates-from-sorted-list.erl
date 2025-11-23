-module(solution).
-export([delete_duplicates/1]).

-record(list_node, {val=0, next=null}).

delete_duplicates(null) -> null;
delete_duplicates(Node = #list_node{val = Val, next = Next}) ->
    case Next of
        null -> Node;
        #list_node{val = NextVal} ->
            if Val == NextVal ->
                Node#list_node{next = delete_duplicates(skip_all_duplicates(Next, Val))};
            else ->
                Node#list_node{next = delete_duplicates(Next)}
            end
    end.

skip_all_duplicates(null, _TargetVal) -> null;
skip_all_duplicates(Node = #list_node{val = Val, next = Next}, TargetVal) ->
    if Val == TargetVal ->
        skip_all_duplicates(Next, TargetVal);
    else ->
        Node
    end.