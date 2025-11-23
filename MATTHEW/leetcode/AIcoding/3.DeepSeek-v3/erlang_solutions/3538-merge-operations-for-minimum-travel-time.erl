-module(solution).
-export([minimum_travel_time/1]).

minimum_travel_time(Stations) ->
    N = length(Stations),
    DP = lists:duplicate(N, lists:duplicate(N, 0)),
    minimum_travel_time(Stations, 0, N - 1, DP).

minimum_travel_time(Stations, I, J, DP) ->
    case I == J of
        true -> 0;
        false ->
            case lists:nth(I + 1, lists:nth(J + 1, DP)) of
                0 ->
                    Min = lists:min([minimum_travel_time(Stations, I, K, DP) + 
                                    minimum_travel_time(Stations, K + 1, J, DP) + 
                                    lists:sum(lists:sublist(Stations, I + 1, K - I + 1)) + 
                                    lists:sum(lists:sublist(Stations, K + 2, J - K)) || 
                                    K <- lists:seq(I, J - 1)]),
                    UpdatedDP = update_dp(DP, I, J, Min),
                    Min;
                Val -> Val
            end
    end.

update_dp(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = lists:sublist(Row, 1, J) ++ [Val] ++ lists:nthtail(J + 1, Row),
    lists:sublist(DP, 1, I) ++ [NewRow] ++ lists:nthtail(I + 1, DP).