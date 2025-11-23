-spec max_depth(Node :: #node{} | null) -> integer().
max_depth(null) -> 0;
max_depth(#node{children = []}) -> 1;
max_depth(#node{children = Children}) ->
    1 + lists:max(lists:map(fun max_depth/1, Children)).