-module(solution).
-export([fireworks/1]).

fireworks(Root) ->
    AllValues = collect_values(Root, []),
    sets:size(sets:from_list(AllValues)).

collect_values([Value, Children], Acc) ->
    NewAcc = [Value | Acc],
    lists:foldl(fun(Child, CurrentAcc) ->
                        collect_values(Child, CurrentAcc)
                end, NewAcc, Children).