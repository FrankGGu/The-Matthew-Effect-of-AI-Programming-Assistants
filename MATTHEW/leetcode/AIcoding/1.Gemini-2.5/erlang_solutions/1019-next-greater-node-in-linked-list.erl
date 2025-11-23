-module(solution).
-export([next_greater_nodes/1]).

next_greater_nodes(Head) ->
    NodesWithIndices = list_to_indexed_list(Head, 0, []),
    NumNodes = length(NodesWithIndices),
    {_FinalStack, AnsMap} = process_nodes(NodesWithIndices, [], #{}),
    build_result_list(0, NumNodes, AnsMap, []).

list_to_indexed_list(null, _Idx, Acc) ->
    lists:reverse(Acc);
list_to_indexed_list(#{val := Val, next := Next}, Idx, Acc) ->
    list_to_indexed_list(Next, Idx + 1, [{Val, Idx} | Acc]).

process_nodes([], Stack, AnsMap) ->
    {Stack, AnsMap};
process_nodes([{CurrentVal, CurrentIdx} | RestNodes], Stack, AnsMap) ->
    {NewStack, NewAnsMap} = pop_stack(CurrentVal, Stack, AnsMap),
    process_nodes(RestNodes, [{CurrentVal, CurrentIdx} | NewStack], NewAnsMap).

pop_stack(CurrentVal, [{PrevVal, PrevIdx} | RestStack], AnsMap) when CurrentVal > PrevVal ->
    NewAnsMap = maps:put(PrevIdx, CurrentVal, AnsMap),
    pop_stack(CurrentVal, RestStack, NewAnsMap);
pop_stack(_CurrentVal, Stack, AnsMap) ->
    {Stack, AnsMap}.

build_result_list(Idx, NumNodes, AnsMap, Acc) when Idx < NumNodes ->
    Val = maps:get(Idx, AnsMap, 0),
    build_result_list(Idx + 1, NumNodes, AnsMap, [Val | Acc]);
build_result_list(_Idx, _NumNodes, _AnsMap, Acc) ->
    lists:reverse(Acc).