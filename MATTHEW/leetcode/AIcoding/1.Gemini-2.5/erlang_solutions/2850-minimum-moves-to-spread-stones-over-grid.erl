-module(solution).
-export([minimumMoves/1]).

minimumMoves(Grid) ->
    {Sources, Sinks} = collect_stones(Grid),
    solve(Sources, Sinks).

collect_stones(Grid) ->
    collect_stones_recursive(0, 0, Grid, [], []).

collect_stones_recursive(3, _, _, Sources, Sinks) ->
    {lists:reverse(Sources), lists:reverse(Sinks)};
collect_stones_recursive(R, 3, Grid, Sources, Sinks) ->
    collect_stones_recursive(R + 1, 0, Grid, Sources, Sinks);
collect_stones_recursive(R, C, Grid, Sources, Sinks) ->
    Stones = lists:nth(C + 1, lists:nth(R + 1, Grid)),
    {FinalSources, FinalSinks} =
        if
            Stones > 1 ->
                AddSources = lists:duplicate(Stones - 1, {R, C}),
                {AddSources ++ Sources, Sinks};
            Stones == 0 ->
                {Sources, [{R, C} | Sinks]};
            true ->
                {Sources, Sinks}
        end,
    collect_stones_recursive(R, C + 1, Grid, FinalSources, FinalSinks).

solve(Sources, Sinks) ->
    solve_recursive(Sources, Sinks).

solve_recursive([], []) -> 0;
solve_recursive([Source | RestSources], Sinks) ->
    MinCost = 1000000000,
    lists:foldl(fun(Index, AccMin) ->
                        Sink = lists:nth(Index, Sinks),
                        Cost = abs(element(1, Source) - element(1, Sink)) + abs(element(2, Source) - element(2, Sink)),
                        RemainingSinks = remove_nth(Index, Sinks),
                        TotalCost = Cost + solve_recursive(RestSources, RemainingSinks),
                        min(AccMin, TotalCost)
                end, MinCost, lists:seq(1, length(Sinks))).

remove_nth(N, List) ->
    {L1, [_ | L2]} = lists:split(N - 1, List),
    L1 ++ L2.