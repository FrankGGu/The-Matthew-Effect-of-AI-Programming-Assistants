-module(solution).
-export([decorateRecord/1]).

decorateRecord(Root) ->
    case Root of
        nil ->
            [];
        _ ->
            bfs([Root], [])
    end.

bfs([], Acc) ->
    lists:reverse(Acc);
bfs(CurrentLevelNodes, Acc) ->
    {CurrentLevelValues, NextLevelNodes} = process_level(CurrentLevelNodes, [], []);
    case NextLevelNodes of
        [] ->
            lists:reverse([CurrentLevelValues | Acc]);
        _ ->
            bfs(NextLevelNodes, [CurrentLevelValues | Acc])
    end.

process_level([], CurrentLevelValuesAcc, NextLevelNodesAcc) ->
    {lists:reverse(CurrentLevelValuesAcc), lists:reverse(NextLevelNodesAcc)};
process_level([{Val, Left, Right} | Rest], CurrentLevelValuesAcc, NextLevelNodesAcc) ->
    NewNextLevelNodesAcc = add_children_to_acc(Left, Right, NextLevelNodesAcc),
    process_level(Rest, [Val | CurrentLevelValuesAcc], NewNextLevelNodesAcc).

add_children_to_acc(nil, nil, Acc) ->
    Acc;
add_children_to_acc(nil, Right, Acc) ->
    [Right | Acc];
add_children_to_acc(Left, nil, Acc) ->
    [Left | Acc];
add_children_to_acc(Left, Right, Acc) ->
    [Right, Left | Acc].