-module(evaluate_division).
-export([calc_equation/2]).

calc_equation(Values, Equations) ->
    Graph = build_graph(Equations),
    Results = [evaluate(Equation, Graph) || Equation <- Values],
    Results.

build_graph(Equations) ->
    lists:foldl(fun({A, B, Val}, Acc) ->
        Acc1 = add_edge(Acc, A, B, Val),
        add_edge(Acc1, B, A, 1.0 / Val)
    end, dict:new(), Equations).

add_edge(Graph, A, B, Val) ->
    case dict:is_key(A, Graph) of
        true ->
            dict:update(A, fun(Edges) -> [{B, Val} | Edges] end, Graph);
        false ->
            dict:store(A, [{B, Val}], Graph)
    end.

evaluate({A, B}, Graph) ->
    case dict:is_key(A, Graph) of
        true ->
            case dict:is_key(B, Graph) of
                true ->
                    dfs(A, B, Graph, dict:new(), 1.0);
                false ->
                    -1.0
            end;
        false ->
            -1.0
    end.

dfs(Node, Target, Graph, Visited, Result) ->
    case Node == Target of
        true ->
            Result;
        false ->
            case dict:is_key(Node, Graph) of
                true ->
                    case dict:is_key(Node, Visited) of
                        true ->
                            -1.0;
                        false ->
                            Visited1 = dict:store(Node, true, Visited),
                            lists:foldl(fun({Next, Val}, Acc) ->
                                case Acc of
                                    -1.0 ->
                                        dfs(Next, Target, Graph, Visited1, Result * Val);
                                    _ ->
                                        Acc
                                end
                            end, -1.0, dict:fetch(Node, Graph))
                    end;
                false ->
                    -1.0
            end
    end.