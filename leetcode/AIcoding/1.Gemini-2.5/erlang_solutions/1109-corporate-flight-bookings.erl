-module(solution).
-export([corp_flight_bookings/2]).

corp_flight_bookings(Bookings, N) ->
    DiffMap = lists:foldl(
        fun([First, Last, Seats], AccMap) ->
            Map1 = maps:update_with(First - 1, fun(Val) -> Val + Seats end, Seats, AccMap),
            if Last < N ->
                maps:update_with(Last, fun(Val) -> Val - Seats end, -Seats, Map1);
            true ->
                Map1
            end
        end,
        maps:new(),
        Bookings
    ),
    compute_prefix_sums_from_map(0, N, DiffMap, 0, []).

compute_prefix_sums_from_map(Index, N, _DiffMap, _CurrentSum, AccResult) when Index >= N ->
    lists:reverse(AccResult);
compute_prefix_sums_from_map(Index, N, DiffMap, CurrentSum, AccResult) ->
    Diff = maps:get(Index, DiffMap, 0),
    NewSum = CurrentSum + Diff,
    compute_prefix_sums_from_map(Index + 1, N, DiffMap, NewSum, [NewSum | AccResult]).