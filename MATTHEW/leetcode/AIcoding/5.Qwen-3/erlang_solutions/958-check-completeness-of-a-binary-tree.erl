-module(solution).
-export([is_complete_tree/1]).

is_complete_tree(nil) -> true;
is_complete_tree(Root) ->
    {_, IsComplete} = bfs(Root, 1, 0),
    IsComplete.

bfs(nil, _, _) -> {0, true};
bfs(Node, Index, MaxIndex) ->
    [Val, Left, Right] = Node,
    case Index > MaxIndex of
        true -> {Index, false};
        false ->
            {LIndex, LStatus} = bfs(Left, Index * 2, MaxIndex),
            {RIndex, RStatus} = bfs(Right, Index * 2 + 1, max(MaxIndex, LIndex)),
            case LStatus of
                false -> {RIndex, false};
                true -> {RIndex, RStatus}
            end
    end.