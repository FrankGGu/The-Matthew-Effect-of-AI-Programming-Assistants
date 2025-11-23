-module(solution).
-export([calc_equation/3]).

%% Helper function to create a graph with the equations and values
-spec build_graph([[string()]]) -> map().
build_graph(Equations) ->
    lists:foldl(fun([A, B], Acc) ->
                    case maps:find(A, Acc) of
                        {ok, M} -> maps:put(A, maps:put(B, Value, M), Acc);
                        error -> maps:put(A, #{B => Value}, Acc)
                    end
                end, #{}, Equations).

%% Function to find the path from start to end.
-spec find_path(map(), string(), string(), map()) -> float().
find_path(Graph, Start, End, Visited) ->
    case maps:find(Start, Graph) of
        {ok, Neighbors} ->
            case maps:find(End, Neighbors) of
                {ok, Value} -> Value;
                error ->
                    case lists:foldl(fun(B, Acc) ->
                                         if
                                            not maps:find(B, Visited) -> true;
                                            true -> false
                                         end -> Acc;
                                         true -> Acc
                                      end, 0.0, maps:keys(Neighbors)) of
                        0.0 -> -1.0;
                        _ -> Value
                    end
            end;
        error -> -1.0
    end.

%% The main function to process the equations and queries
-spec calc_equation([[string()]], [float()], [[string()]]) -> [float()].
calc_equation(Equations, Values, Queries) ->
    Graph = build_graph(Equations),
    lists:map(fun([C, D]) -> find_path(Graph, C, D, #{}) end, Queries).
