-module(solution).
-export([two_out_of_three/3]).

two_out_of_three(List1, List2, List3) ->
    Sets = [maps:from_list(List1), maps:from_list(List2), maps:from_list(List3)],
    Combined = lists:foldl(fun(Set, Acc) -> maps:merge(fun(_, V1, V2) -> V1 + V2 end, Acc, Set) end, maps:new(), Sets),
    maps:filter(fun({_, V}) -> V >= 2 end, Combined),
    maps:size(Combined).