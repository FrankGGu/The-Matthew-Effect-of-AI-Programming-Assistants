-module(parallel_courses_iii).
-export([minimum_time/3]).

minimum_time(N, Prerequisites, Time) ->
    Indegree = lists:seq(1, N, 0),
    Graph = dict:new(),
    lists:foreach(fun([U, V]) ->
                      dict:update_counter(U, 1, 1, Graph),
                      dict:update(V, fun(L) -> [U | L];
                                     (_) -> [U]
                                  end, [], Graph)
                  end, Prerequisites),
    IndegreeList = lists:seq(1, N, 0),
    UpdatedIndegree = lists:foldl(fun(K, Acc) ->
                                      case dict:is_key(K, Graph) of
                                          true ->
                                              L = dict:fetch(K, Graph),
                                              lists:foldl(fun(V, A) ->
                                                              A#{V => maps:get(V, A, 0) + 1}
                                                          end, Acc, L);
                                          false ->
                                              Acc
                                      end
                                  end, maps:from_list(lists:zip(IndegreeList, Indegree)), lists:seq(1, N)),

    Q = queue:new(),
    StartTime = lists:seq(1, N, 0),
    UpdatedStartTime = lists:foldl(fun(I, Acc) ->
                                        Acc#{I => Time[I - 1]}
                                    end, maps:from_list(lists:zip(IndegreeList, StartTime)), lists:seq(1, N)),

    lists:foreach(fun(I) ->
                      case maps:get(I, UpdatedIndegree, 0) of
                          0 -> queue:in(I, Q);
                          _ -> ok
                      end
                  end, lists:seq(1, N)),

    {FinalQ, FinalStartTime} = bfs(Q, Graph, Time, UpdatedStartTime, UpdatedIndegree),

    lists:max(maps:values(FinalStartTime)).

bfs(Q, Graph, Time, StartTime, Indegree) ->
    case queue:is_empty(Q) of
        true -> {Q, StartTime};
        false ->
            {I, NewQ} = queue:out(Q),
            case dict:is_key(I, Graph) of
                true ->
                    L = dict:fetch(I, Graph),
                    NewIndegree = lists:foldl(fun(V, Acc) ->
                                                  NewCount = maps:get(V, Acc) - 1,
                                                  case NewCount of
                                                      0 -> queue:in(V, NewQ);
                                                      _ -> ok
                                                  end,
                                                  Acc#{V => NewCount}
                                              end, Indegree, L),
                    NewStartTime = lists:foldl(fun(V, Acc) ->
                                                    MaxTime = max(maps:get(V, Acc, 0),
                                                                  maps:get(I, StartTime, 0) + Time[V - 1]),
                                                    Acc#{V => MaxTime}
                                                end, StartTime, L),
                    bfs(NewQ, Graph, Time, NewStartTime, NewIndegree);
                false ->
                    bfs(NewQ, Graph, Time, StartTime, Indegree)
            end
    end.