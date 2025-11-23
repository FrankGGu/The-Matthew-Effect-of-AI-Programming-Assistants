-module(solution).
-export([minimum_time/2]).

minimum_time(Tires, ChangeTime) ->
    Mem = ets:new(mem, [set, private]),
    {Min1, Min2} = lists:foldl(fun([f, r], {M1, M2}) -> 
                                   {min(M1, f + r), min(M2, f)} 
                               end, {infinity, infinity}, Tires),
    DP = ets:new(dp, [set, private]),
    ets:insert(DP, {0, 0}),
    Result = solve(1, Min1, Min2, ChangeTime, DP, Mem),
    ets:delete(DP),
    ets:delete(Mem),
    Result.

solve(Lap, Min1, Min2, ChangeTime, DP, Mem) ->
    case ets:lookup(DP, Lap) of
        [{Lap, Time}] -> Time;
        [] ->
            case ets:lookup(Mem, Lap) of
                [{Lap, Time}] -> Time;
                [] ->
                    MinTime = if
                        Lap == 1 -> Min2;
                        true ->
                            case ets:lookup(DP, Lap - 1) of
                                [{Lap - 1, PrevTime}] ->
                                    min(PrevTime + Min1, 
                                        case ets:lookup(DP, Lap - 2) of
                                            [{Lap - 2, PrevPrevTime}] ->
                                                PrevPrevTime + ChangeTime + Min2;
                                            [] ->
                                                infinity
                                        end);
                                [] -> infinity
                            end
                    end,
                    ets:insert(DP, {Lap, MinTime}),
                    ets:insert(Mem, {Lap, MinTime}),
                    MinTime
            end
    end.