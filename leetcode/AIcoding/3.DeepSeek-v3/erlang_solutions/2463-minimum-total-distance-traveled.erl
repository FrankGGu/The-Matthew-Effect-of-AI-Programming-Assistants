-module(solution).
-export([minimum_total_distance/1]).

minimum_total_distance(RobotPositions) ->
    Sorted = lists:sort(RobotPositions),
    N = length(Sorted),
    DP = lists:duplicate(N, lists:duplicate(N, 0)),
    DP1 = fill_dp(DP, Sorted, 0, N - 1),
    lists:nth(1, lists:nth(1, DP1)).

fill_dp(DP, _, I, J) when I >= J ->
    DP;
fill_dp(DP, Sorted, I, J) ->
    case I + 1 == J of
        true ->
            Cost = lists:nth(J + 1, Sorted) - lists:nth(I + 1, Sorted),
            Updated = update_dp(DP, I, J, Cost),
            fill_dp(Updated, Sorted, I + 1, J - 1);
        false ->
            Cost1 = (lists:nth(J + 1, Sorted) - lists:nth(I + 1, Sorted)) + lists:nth(I + 1, lists:nth(J, DP)),
            Cost2 = (lists:nth(J + 1, Sorted) - lists:nth(I + 1, Sorted)) + lists:nth(I, lists:nth(J - 1, DP)),
            Cost = min(Cost1, Cost2),
            Updated = update_dp(DP, I, J, Cost),
            fill_dp(Updated, Sorted, I + 1, J - 1)
    end.

update_dp(DP, I, J, Value) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setnth(J + 1, Row, Value),
    setnth(I + 1, DP, NewRow).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].