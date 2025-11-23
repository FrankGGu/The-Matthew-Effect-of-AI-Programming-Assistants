-module(solution).
-export([num_time_to_inform/3]).

num_time_to_inform(N, HeadID, Manager, InformTime) ->
    Graph = lists:foldl(fun({M, E}, Acc) ->
        case lists:keyfind(M, 1, Acc) of
            false -> [{M, [E]} | Acc];
            {M, Employees} -> lists:keyreplace(M, 1, Acc, {M, [E | Employees]})
        end
    end, [], lists:zip(Manager, lists:seq(0, N - 1))),
    inform_time(Graph, HeadID, InformTime).

inform_time(Graph, HeadID, InformTime) ->
    case lists:keyfind(HeadID, 1, Graph) of
        false -> 0;
        {_, Employees} ->
            case Employees of
                [] -> 0;
                _ -> 
                    MaxTime = lists:max([inform_time(Graph, E, InformTime) + lists:nth(E + 1, InformTime) || E <- Employees]),
                    MaxTime
            end
    end.