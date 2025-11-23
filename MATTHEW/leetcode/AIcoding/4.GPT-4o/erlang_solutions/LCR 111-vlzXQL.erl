-module(solution).
-export([calc_equation/2]).

calc_equation(Equations, Values) ->
    Graph = build_graph(Equations, Values),
    lists:map(fun({A, B}) -> find_value(Graph, A, B) end, Equations).

build_graph(Equations, Values) ->
    lists:foldl(fun({A, B}, Acc) ->
        map_put(Acc, A, lists:append([{B, hd(Values)} | map_get(Acc, A)])),
        map_put(Acc, B, lists:append([{A, 1 / hd(Values)} | map_get(Acc, B)])
    end, #{}).

find_value(Graph, A, B) ->
    case maps:is_key(A, Graph) andalso maps:is_key(B, Graph) of
        false -> -1.0;
        true ->
            case dfs(Graph, A, B, #{}, 1.0) of
                {found, Value} -> Value;
                _ -> -1.0
            end
    end.

dfs(Graph, Current, Target, Visited, Acc) ->
    case Current == Target of
        true -> {found, Acc};
        false ->
            case maps:get(Current, Graph) of
                [] -> not_found;
                Neighbors ->
                    lists:foldl(fun({Neighbor, Value}, Acc) ->
                        case maps:is_key(Neighbor, Visited) of
                            true -> Acc;
                            false -> dfs(Graph, Neighbor, Target, map_put(Visited, Neighbor, true), Acc * Value)
                        end
                    end, not_found, Neighbors)
            end
    end.

not_found -> not_found.