-module(solution).
-export([path_sum/3]).

path_sum(Tree, Target, Path) ->
    case Tree of
        {nil} ->
            [];
        {Value, Left, Right} ->
            NewTarget = Target - Value,
            if
                NewTarget == 0 andalso (Left == nil andalso Right == nil) ->
                    [[Value]];
                true ->
                    LeftPaths = path_sum(Left, NewTarget, [Value | Path]),
                    RightPaths = path_sum(Right, NewTarget, [Value | Path]),
                    lists:append(LeftPaths, RightPaths)
            end
    end.