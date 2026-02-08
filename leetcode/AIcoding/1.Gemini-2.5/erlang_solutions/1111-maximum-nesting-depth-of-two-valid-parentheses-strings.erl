-module(solution).
-export([max_depth_after_split/1]).

max_depth_after_split(S) ->
    max_depth_after_split_helper(S, 0, []).

max_depth_after_split_helper([], _Depth, Acc) ->
    lists:reverse(Acc);
max_depth_after_split_helper([C|Rest], Depth, Acc) ->
    case C of
        $( ->
            Assignment = Depth rem 2,
            NewDepth = Depth + 1,
            max_depth_after_split_helper(Rest, NewDepth, [Assignment | Acc]);
        $) ->
            NewDepth = Depth - 1,
            Assignment = NewDepth rem 2,
            max_depth_after_split_helper(Rest, NewDepth, [Assignment | Acc])
    end.