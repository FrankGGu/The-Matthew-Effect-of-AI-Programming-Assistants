-module(path_existence_queries_ii).
-export([solve/2]).

solve(N, Edges, Queries) ->
    Graph = build_graph(N, Edges),
    lists:map(fun(Query) ->
                      case find_path(Graph, Query) of
                          true ->
                              1;
                          false ->
                              0
                      end
              end, Queries).

build_graph(N, Edges) ->
    lists:foldl(fun({U, V, W}, Acc) ->
                         case maps:is_key(U, Acc) of
                             true ->
                                 Acc#{U => maps:update_with(V, fun(W0) -> min(W0, W) end, W, maps:get(U, Acc))};
                             false ->
                                 Acc#{U => #{V => W}}
                         end
                 end, #{}, Edges).

find_path(Graph, {Start, End, MaxWeight}) ->
    find_path_helper(Graph, Start, End, MaxWeight, [], []).

find_path_helper(_Graph, Start, End, _MaxWeight, Visited, Path) when Start == End ->
    true;
find_path_helper(Graph, Start, End, MaxWeight, Visited, Path) ->
    case lists:member(Start, Visited) of
        true ->
            false;
        false ->
            case maps:is_key(Start, Graph) of
                false ->
                    false;
                true ->
                    Neighbors = maps:get(Start, Graph),
                    lists:any(fun(Neighbor) ->
                                      Weight = maps:get(Neighbor, Neighbors),
                                      if Weight =< MaxWeight ->
                                          find_path_helper(Graph, Neighbor, End, MaxWeight, [Start | Visited], [Neighbor | Path])
                                      else
                                          false
                                      end
                              end, maps:keys(Neighbors))
            end
    end.