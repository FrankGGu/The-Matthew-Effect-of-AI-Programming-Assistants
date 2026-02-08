-module(solution).
-export([find_min_time/1]).

find_min_time(Rooms) ->
    N = length(Rooms),
    Graph = lists:foldl(fun({_, T}, Acc) -> 
        lists:foldl(fun({Next, Time}, Acc2) -> 
            case lists:keyfind(Next, 1, Acc2) of
                false -> [{Next, Time + T} | Acc2];
                {Next, OldTime} -> [{Next, min(OldTime, Time + T)} | lists:keydelete(Next, 1, Acc2)]
            end
        end, Acc, Rooms) 
    end, [{1, 0}], Rooms),
    case lists:keyfind(N, 1, Graph) of
        {N, Time} -> Time;
        false -> -1
    end.