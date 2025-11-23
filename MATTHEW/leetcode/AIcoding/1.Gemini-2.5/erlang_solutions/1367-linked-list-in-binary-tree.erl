-module(solution).
-export([isSubPath/2]).

isSubPath(Head, Root) ->
    is_sub_path_recursive(Head, Root).

is_sub_path_recursive(_Head, nil) ->
    false;
is_sub_path_recursive(Head, Root) ->
    match_path(Head, Root)
    orelse
    is_sub_path_recursive(Head, maps:get(left, Root))
    orelse
    is_sub_path_recursive(Head, maps:get(right, Root)).

match_path(nil, _TreeNode) ->
    true;
match_path(_ListHead, nil) ->
    false;
match_path(ListHead, TreeNode) ->
    ListVal = maps:get(val, ListHead),
    TreeVal = maps:get(val, TreeNode),

    if ListVal == TreeVal ->
        match_path(maps:get(next, ListHead), maps:get(left, TreeNode))
        orelse
        match_path(maps:get(next, ListHead), maps:get(right, TreeNode));
    true ->
        false
    end.