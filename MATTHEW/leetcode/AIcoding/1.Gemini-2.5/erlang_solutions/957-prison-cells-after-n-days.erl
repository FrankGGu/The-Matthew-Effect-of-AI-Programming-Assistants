-module(solution).
-export([prisonAfterNDays/2]).

prisonAfterNDays(Cells, N) ->
    solve_recursive(Cells, N, 0, maps:new(), []).

solve_recursive(CurrentCells, N, Day, SeenStates, StatesHistory) ->
    if Day == N ->
        CurrentCells;
    true ->
        case maps:find(CurrentCells, SeenStates) of
            {ok, PrevDay} ->
                CycleLength = Day - PrevDay,
                RemainingDaysToSimulate = N - Day,
                OffsetInCycle = RemainingDaysToSimulate rem CycleLength,
                TargetDayInHistory = PrevDay + OffsetInCycle,
                lists:nth(TargetDayInHistory + 1, StatesHistory);
            undefined ->
                NextCells = calculate_next_day(CurrentCells),
                NewSeenStates = maps:put(CurrentCells, Day, SeenStates),
                NewStatesHistory = StatesHistory ++ [CurrentCells],
                solve_recursive(NextCells, N, Day + 1, NewSeenStates, NewStatesHistory)
        end
    end.

calculate_next_day(Cells) ->
    [C0, C1, C2, C3, C4, C5, C6, C7] = Cells,

    NewC0 = 0,
    NewC1 = if C0 == C2 -> 1; true -> 0 end,
    NewC2 = if C1 == C3 -> 1; true -> 0 end,
    NewC3 = if C2 == C4 -> 1; true -> 0 end,
    NewC4 = if C3 == C5 -> 1; true -> 0 end,
    NewC5 = if C4 == C6 -> 1; true -> 0 end,
    NewC6 = if C5 == C7 -> 1; true -> 0 end,
    NewC7 = 0,

    [NewC0, NewC1, NewC2, NewC3, NewC4, NewC5, NewC6, NewC7].