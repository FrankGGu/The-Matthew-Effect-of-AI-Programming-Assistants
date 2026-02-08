-module(same_tree).
-export([is_same_tree/2]).

is_same_tree(nil, nil) -> true;
is_same_tree(_, nil) -> false;
is_same_tree(nil, _) -> false;
is_same_tree(#tree{val = V1, left = L1, right = R1}, #tree{val = V2, left = L2, right = R2}) ->
    V1 == V2 andalso is_same_tree(L1, L2) andalso is_same_tree(R1, R2).