-module(solution).
-export([zigzagLevelOrder/1]).

zigzagLevelOrder(nil) ->
    [];
zigzagLevelOrder(Root) ->
    bfs(queue:in(Root, queue:new()), [], 0).

bfs(Q, Acc, Level) when queue:is_empty(Q) ->
    lists:reverse(Acc);
bfs(Q, Acc, Level) ->
    CurrentLevelSize = queue:len(Q),
    {CurrentLevelVals, NextLevelQ} = process_level_nodes(Q, CurrentLevelSize, [], queue:new()),

    LevelResult = case Level rem 2 of
                      0 -> CurrentLevelVals;
                      1 -> lists:reverse(CurrentLevelVals)
                  end,

    bfs(NextLevelQ, [LevelResult | Acc], Level + 1).

process_level_nodes(Q, 0, AccVals, NextLevelQ) ->
    {lists:reverse(AccVals), NextLevelQ};
process_level_nodes(Q, Count, AccVals, NextLevelQ) ->
    {value, {Val, Left, Right}, Q1} = queue:out(Q),

    NextLevelQ1 = add_child_to_queue(Left, NextLevelQ),
    NextLevelQ2 = add_child_to_queue(Right, NextLevelQ1),

    process_level_nodes(Q1, Count - 1, [Val | AccVals], NextLevelQ2).

add_child_to_queue(nil, Q) ->
    Q;
add_child_to_queue(Node, Q) ->
    queue:in(Node, Q).