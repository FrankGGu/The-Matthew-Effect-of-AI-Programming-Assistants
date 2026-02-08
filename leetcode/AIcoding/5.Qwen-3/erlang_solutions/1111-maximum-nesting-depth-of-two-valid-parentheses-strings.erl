-module(maximum_nesting_depth_of_two_valid_parentheses_strings).
-export([maxDepthAfterSplit/1]).

maxDepthAfterSplit(Str) ->
    max_depth_after_split(Str, 0, 0, []).

max_depth_after_split([], _, _, Acc) ->
    lists:max(Acc);
max_depth_after_split([H | T], Depth, Count, Acc) ->
    case H of
        '(' ->
            NewDepth = Depth + 1,
            max_depth_after_split(T, NewDepth, Count + 1, [NewDepth | Acc]);
        ')' ->
            NewDepth = Depth - 1,
            max_depth_after_split(T, NewDepth, Count + 1, [NewDepth | Acc])
    end.