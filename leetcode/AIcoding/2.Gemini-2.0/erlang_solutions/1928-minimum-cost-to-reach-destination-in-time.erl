-module(minimum_cost_to_reach_destination_in_time).
-export([minCost, solve/4]).

minCost(MaxTime, Costs, Time) ->
    N = length(Costs),
    solve(N, MaxTime, Costs, Time).

solve(N, MaxTime, Costs, Time) ->
    DP = array:new([N + 1, MaxTime + 1], {cost, infinity}),
    array:set({1, 0}, {cost, 0}, DP),

    {ok, Result} = solve_helper(N, MaxTime, Costs, Time, DP),
    Result.

solve_helper(N, MaxTime, Costs, Time, DP) ->

    Edges = lists:zip(Time, Costs),

    for(I, 1, N,
        for(J, 1, N,
            if
                I == J ->
                    ok;
                true ->
                    T = lists:nth(I, Time),
                    C = lists:nth(I, Costs),

                    for(K, 0, MaxTime,
                        case array:get({I, K}, DP) of
                            {cost, infinity} ->
                                ok;
                            {cost, Cost} ->
                                NewTime = K + T,
                                if NewTime =< MaxTime ->
                                    case array:get({J, NewTime}, DP) of
                                        {cost, Infinity} when Infinity == infinity ->
                                            array:set({J, NewTime}, {cost, Cost + C}, DP);
                                        {cost, ExistingCost} ->
                                            if Cost + C < ExistingCost ->
                                                array:set({J, NewTime}, {cost, Cost + C}, DP);
                                            else
                                                ok
                                            end
                                    end;
                                else
                                    ok
                                end
                        end
                    )
            end
        )
    ),

    MinCost = lists:foldl(
        fun(K, Acc) ->
            case array:get({N, K}, DP) of
                {cost, Cost} when Cost < Acc ->
                    Cost;
                _ ->
                    Acc
            end
        end,
        infinity,
        lists:seq(0, MaxTime)
    ),

    if MinCost == infinity ->
        {ok, -1};
    else
        {ok, MinCost}
    end.