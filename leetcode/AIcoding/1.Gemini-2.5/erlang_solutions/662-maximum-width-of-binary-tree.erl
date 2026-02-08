-module(solution).
-export([max_width_of_binary_tree/1]).

max_width_of_binary_tree(null) -> 0;
max_width_of_binary_tree(Root) ->
    bfs([{Root, 0}], 1).

bfs([], MaxWidth) -> MaxWidth;
bfs(CurrentLevelQueue, MaxWidth) ->
    {_NodeMin, MinPos} = lists:hd(CurrentLevelQueue),
    {_NodeMax, MaxPos} = lists:last(CurrentLevelQueue),

    CurrentWidth = MaxPos - MinPos + 1,
    NewMaxWidth = max(MaxWidth, CurrentWidth),

    NextLevelQueue = build_next_level_queue(CurrentLevelQueue, MinPos),

    bfs(NextLevelQueue, NewMaxWidth).

build_next_level_queue(CurrentLevelQueue, MinPosOfCurrentLevel) ->
    NextLevelQueueReversed = lists:foldl(
        fun({Node, Pos}, Acc) ->
            {_Val, Left, Right} = Node,
            RelativePos = Pos - MinPosOfCurrentLevel,

            Acc1 = case Right of
                       null -> Acc;
                       _ -> [{Right, 2 * RelativePos + 1}|Acc]
                   end,
            case Left of
                null -> Acc1;
                _ -> [{Left, 2 * RelativePos}|Acc1]
            end
        end, [], CurrentLevelQueue),
    lists:reverse(NextLevelQueueReversed).