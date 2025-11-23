-module(solution).
-export([number_of_good_partitions/1]).

number_of_good_partitions(Nums) ->
    Mod = 1000000007,
    N = length(Nums),
    LastOcc = build_last_occurrences(Nums, N),
    Cuts = count_cuts_optimized(Nums, 0, 0, 0, LastOcc, N),
    power(2, Cuts, Mod).

build_last_occurrences(Nums, N) ->
    lists:foldl(
        fun({Val, Idx}, Acc) -> maps:put(Val, Idx, Acc) end,
        maps:new(),
        lists:zip(Nums, lists:seq(0, N - 1))
    ).

count_cuts_optimized([], _CurrentIdx, _MaxReach, Cuts, _LastOcc, _N) ->
    Cuts;
count_cuts_optimized([H|T], CurrentIdx, MaxReach, Cuts, LastOcc, N) ->
    NewMaxReach = max(MaxReach, maps:get(H, LastOcc)),
    NewCuts = if CurrentIdx == NewMaxReach andalso CurrentIdx < N - 1 -> Cuts + 1; true -> Cuts end,
    count_cuts_optimized(T, CurrentIdx + 1, NewMaxReach, NewCuts, LastOcc, N).

power(Base, Exp, Mod) ->
    power_rec(Base, Exp, Mod, 1).

power_rec(_Base, 0, _Mod, Acc) ->
    Acc;
power_rec(Base, Exp, Mod, Acc) ->
    if Exp rem 2 == 1 ->
        power_rec((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
    true ->
        power_rec((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.