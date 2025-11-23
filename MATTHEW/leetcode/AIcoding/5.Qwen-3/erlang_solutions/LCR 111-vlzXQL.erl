-module(equation_division).
-export([calc_equation/2]).

calc_equation(Edges, Queries) ->
    Graph = build_graph(Edges),
    [eval_query(Query, Graph) || Query <- Queries].

build_graph(Edges) ->
    lists:foldl(fun({A, B, Val}, Acc) ->
        Acc1 = add_edge(A, B, Val, Acc),
        add_edge(B, A, 1.0 / Val, Acc1)
    end, dict:new(), Edges).

add_edge(A, B, Val, Acc) ->
    case dict:is_key(A, Acc) of
        true -> dict:update(A, fun(Entries) -> [{B, Val} | Entries] end, Acc);
        false -> dict:store(A, [{B, Val}], Acc)
    end.

eval_query({A, B}, Graph) ->
    case dict:is_key(A, Graph) of
        true ->
            case dfs(A, B, Graph, dict:new(), 1.0) of
                {ok, Result} -> Result;
                error -> -1.0
            end;
        false -> -1.0
    end.

dfs(Node, Target, Graph, Visited, Current) ->
    case dict:is_key(Node, Visited) of
        true -> error;
        false ->
            Visited1 = dict:store(Node, true, Visited),
            case Node of
                Target -> {ok, Current};
                _ ->
                    case dict:find(Node, Graph) of
                        {ok, Neighbors} ->
                            lists:foldl(fun({Next, Val}, {ok, Res}) -> {ok, Res}; ({Next, Val}, _) ->
                                case dfs(Next, Target, Graph, Visited1, Current * Val) of
                                    {ok, Result} -> {ok, Result};
                                    error -> error
                                end
                            end, error, Neighbors);
                        error -> error
                    end
            end
    end.