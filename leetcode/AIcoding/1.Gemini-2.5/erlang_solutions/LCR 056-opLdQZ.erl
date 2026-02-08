-module(solution).
-export([findTarget/2]).

findTarget(Root, K) ->
    findTarget_recursive(Root, K, gb_sets:empty()).

findTarget_recursive(null, _K, _Seen) ->
    false;
findTarget_recursive({Val, Left, Right}, K, Seen) ->
    TargetComplement = K - Val,
    case gb_sets:is_member(TargetComplement, Seen) of
        true ->
            true;
        false ->
            NewSeen = gb_sets:add(Val, Seen),
            findTarget_recursive(Left, K, NewSeen) orelse findTarget_recursive(Right, K, NewSeen)
    end.