-module(solution).
-export([smallest_string_from_leaf/1]).

smallest_string_from_leaf(Root) ->
    InitialMinString = lists:duplicate(101, $z),
    dfs(Root, [], InitialMinString).

dfs(null, _CurrentPath, AccMinString) ->
    AccMinString;
dfs({Val, Left, Right}, CurrentPath, AccMinString) ->
    NewCurrentPath = [char(Val + $a) | CurrentPath],
    case {Left, Right} of
        {null, null} ->
            case NewCurrentPath =< AccMinString of
                true -> NewCurrentPath;
                false -> AccMinString
            end;
        _ ->
            MinFromLeft = dfs(Left, NewCurrentPath, AccMinString),
            MinFromBoth = dfs(Right, NewCurrentPath, MinFromLeft),
            MinFromBoth
    end.