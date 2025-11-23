-module(merge_nodes_in_between_zeros).
-export([mergeNodes/1]).

mergeNodes(Head) ->
    mergeNodes(Head, 0, []).

mergeNodes(nil, _, Acc) ->
    lists:reverse(Acc);
mergeNodes(#node{val = 0, next = Next}, CurrentSum, Acc) ->
    case CurrentSum of
        0 -> mergeNodes(Next, 0, Acc);
        _ -> mergeNodes(Next, 0, [#node{val = CurrentSum, next = nil} | Acc])
    end;
mergeNodes(#node{val = Val, next = Next}, CurrentSum, Acc) ->
    mergeNodes(Next, CurrentSum + Val, Acc).