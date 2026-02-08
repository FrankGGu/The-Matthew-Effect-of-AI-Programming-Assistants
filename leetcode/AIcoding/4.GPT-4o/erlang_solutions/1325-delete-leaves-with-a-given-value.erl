-module(solution).
-export([removeLeafNodes/2]).

-record(tree, {val, left = none, right = none}).

removeLeafNodes(Root, Target) ->
    case remove(Root, Target) of
        none -> none;
        NewRoot -> NewRoot
    end.

remove(none, _) -> none;
remove(#tree{val = Val, left = L, right = R}, Target) ->
    L1 = remove(L, Target),
    R1 = remove(R, Target),
    case {L1, R1} of
        {none, none} -> if Val == Target -> none; true -> #tree{val = Val, left = L1, right = R1} end;
        {L1, R1} -> #tree{val = Val, left = L1, right = R1}
    end.