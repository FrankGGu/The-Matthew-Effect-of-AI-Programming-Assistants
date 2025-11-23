-module(solution).
-export([width_of_binary_tree/1]).

width_of_binary_tree(nil) -> 0;
width_of_binary_tree(Root) ->
    {MaxWidth, _} = bfs(Root, 0, 1, 0, 0),
    MaxWidth.

bfs(nil, _, _, _, _) -> {0, 0};
bfs(Node, Level, Position, CurrentLevel, MaxWidth) ->
    case Node of
        {Val, Left, Right} ->
            if
                Level == CurrentLevel ->
                    NewMaxWidth = max(MaxWidth, Position),
                    {NewMaxWidth, _} = bfs(Left, Level + 1, 2 * Position, Level + 1, NewMaxWidth),
                    {NewMaxWidth, _} = bfs(Right, Level + 1, 2 * Position + 1, Level + 1, NewMaxWidth),
                    {NewMaxWidth, Level + 1};
                true ->
                    {MaxWidth, CurrentLevel}
            end;
        _ -> {MaxWidth, CurrentLevel}
    end.