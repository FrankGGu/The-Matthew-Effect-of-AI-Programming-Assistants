-module(solution).
-export([mergeNodes/1]).

mergeNodes(List) ->
    mergeNodes(List, 0, []).

mergeNodes([], _Sum, Acc) -> 
    lists:reverse(Acc);
mergeNodes([0 | Tail], Sum, Acc) when Sum > 0 -> 
    mergeNodes(Tail, 0, [Sum | Acc]);
mergeNodes([0 | Tail], _Sum, Acc) -> 
    mergeNodes(Tail, 0, Acc);
mergeNodes([H | Tail], Sum, Acc) -> 
    mergeNodes(Tail, Sum + H, Acc).