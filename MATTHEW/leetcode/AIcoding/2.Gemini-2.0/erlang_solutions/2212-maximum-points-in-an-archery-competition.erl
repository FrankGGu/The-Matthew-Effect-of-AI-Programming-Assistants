-module(archery).
-export([maximum_points/2]).

maximum_points(num_arrows, target_positions) ->
    n = length(target_positions),
    {MaxScore, Result} = solve(num_arrows, target_positions, n, 0, 0, lists:seq(1,n), []),
    lists:reverse(Result).

solve(0, _, _, Score, CurrScore, _, Acc) ->
    {Score, Acc};
solve(_NumArrows, _, 0, Score, CurrScore, _, Acc) ->
    {Score, Acc};
solve(NumArrows, TargetPositions, N, Score, CurrScore, Available, Acc) ->
    Position = lists:nth(N, Available),
    ArrowsNeeded = lists:nth(Position, TargetPositions) + 1,
    if
        NumArrows >= ArrowsNeeded ->
            Score1 = CurrScore + (N - 1),
            {Score2, Acc2} = solve(NumArrows - ArrowsNeeded, TargetPositions, N - 1, Score, Score1, lists:sublist(Available, 1, N - 1), [ArrowsNeeded || _ <- [1]] ++ Acc),
            {Score3, Acc3} = solve(NumArrows, TargetPositions, N - 1, Score, CurrScore, lists:sublist(Available, 1, N - 1), [0 || _ <- [1]] ++ Acc),
            if
                Score2 >= Score3 ->
                    {Score2, Acc2};
                true ->
                    {Score3, Acc3}
            end;
        true ->
            solve(NumArrows, TargetPositions, N - 1, Score, CurrScore, lists:sublist(Available, 1, N - 1), [0 || _ <- [1]] ++ Acc)
    end.