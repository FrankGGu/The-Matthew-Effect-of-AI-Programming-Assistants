-module(solution).
-export([countWays/1]).

compare_ranges({S1, _E1}, {S2, _E2}) when S1 < S2 -> true;
compare_ranges({S1, _E1}, {S2, _E2}) when S1 > S2 -> false;
compare_ranges({_S1, E1}, {_S2, E2}) when E1 < E2 -> true;
compare_ranges(_, _) -> false.

power(Base, Exp, Mod) when Exp == 0 -> 1;
power(Base, Exp, Mod) ->
    Result = power(Base, Exp div 2, Mod),
    SquaredResult = (Result * Result) rem Mod,
    if
        Exp rem 2 == 1 -> (SquaredResult * Base) rem Mod;
        true -> SquaredResult
    end.

countWays(Ranges) ->
    Mod = 1000000007,

    SortedRanges = lists:sort(fun compare_ranges/2, Ranges),

    NumDisjointRanges = calculate_num_disjoint_ranges(SortedRanges),

    if
        NumDisjointRanges == 0 ->
            1;
        true ->
            power(2, NumDisjointRanges - 1, Mod)
    end.

calculate_num_disjoint_ranges([]) ->
    0;
calculate_num_disjoint_ranges([FirstRange | RestRanges]) ->
    calculate_num_disjoint_ranges(RestRanges, FirstRange, 1).

calculate_num_disjoint_ranges([], {_CurrentStart, _CurrentEnd}, Count) ->
    Count;
calculate_num_disjoint_ranges([{NextStart, NextEnd} | RestRanges], {CurrentStart, CurrentEnd}, Count) ->
    if
        NextStart > CurrentEnd ->
            calculate_num_disjoint_ranges(RestRanges, {NextStart, NextEnd}, Count + 1);
        true ->
            NewCurrentEnd = max(CurrentEnd, NextEnd),
            calculate_num_disjoint_ranges(RestRanges, {CurrentStart, NewCurrentEnd}, Count)
    end.