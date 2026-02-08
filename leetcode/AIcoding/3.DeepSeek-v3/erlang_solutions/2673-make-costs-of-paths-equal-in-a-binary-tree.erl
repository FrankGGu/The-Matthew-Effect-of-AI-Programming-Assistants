-spec min_increments(N :: integer(), Cost :: [integer()]) -> integer().
min_increments(N, Cost) ->
    solve(1, Cost).

solve(Index, Cost) when Index > length(Cost) -> 0;
solve(Index, Cost) ->
    Left = solve(2 * Index, Cost),
    Right = solve(2 * Index + 1, Cost),
    Max = max(Left, Right),
    case 2 * Index + 1 =< length(Cost) of
        true -> Max - min(Left, Right);
        false -> 0
    end + Max.