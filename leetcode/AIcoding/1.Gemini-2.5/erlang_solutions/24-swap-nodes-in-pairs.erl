-record(list_node, {val, next}).

swap_pairs(null) ->
    null;
swap_pairs(#list_node{next = null} = Head) ->
    Head;
swap_pairs(#list_node{val = Val1, next = #list_node{val = Val2, next = Rest}} = _Head) ->
    #list_node{val = Val2, next = #list_node{val = Val1, next = swap_pairs(Rest)}}.