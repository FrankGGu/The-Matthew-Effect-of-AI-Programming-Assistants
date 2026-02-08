-module(solution).
-export([solve/3]).

solve(N, Edges, Sources) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
                          maps:update_with(V, fun(List) -> [U | List] end, [U], Acc1)
                      end, maps:new(), Edges),

    Infinity = N,
    InitialDistances = maps:from_list([{I, Infinity} || I <- lists:seq(0, N-1)]),

    {Queue, Distances} = lists:foldl(fun(Source, {QAcc, DAcc}) ->
                                         {queue:in({0, Source}, QAcc), maps:put(Source, 0, DAcc)}
                                     end, {queue:new(), InitialDistances}, Sources),

    FinalDistances = bfs(Queue, Adj, Distances),

    MaxTime = maps:fold(fun(_Node, Time, AccMax) ->
                            max(Time, AccMax)
                        end, 0, FinalDistances),
    MaxTime.

bfs(Queue, Adj, Distances) ->
    case queue:out(Queue) of
        {{value, {Time, Node}}, RestQueue} ->
            case maps:get(Node, Distances) of
                CurrentTime when CurrentTime < Time ->
                    bfs(RestQueue, Adj, Distances);
                _ ->
                    Neighbors = maps:get(Node, Adj, []),
                    {NewQueue, NewDistances} = lists:foldl(fun(Neighbor, {QAcc, DAcc}) ->
                                                               NewTime = Time + 1,
                                                               CurrentNeighborTime = maps:get(Neighbor, DAcc),
                                                               if NewTime < CurrentNeighborTime ->
                                                                      {queue:in({NewTime, Neighbor}, QAcc), maps:put(Neighbor, NewTime, DAcc)};
                                                                  true ->
                                                                      {QAcc, DAcc}
                                                               end
                                                           end, {RestQueue, Distances}, Neighbors),
                    bfs(NewQueue, Adj, NewDistances)
            end;
        {empty, _} ->
            Distances
    end.