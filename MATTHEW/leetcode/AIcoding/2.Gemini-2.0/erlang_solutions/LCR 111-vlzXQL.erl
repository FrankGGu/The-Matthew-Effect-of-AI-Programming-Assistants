-module(evaluate_division).
-export([calcEquation/3]).

calcEquation(Equations, Values, Queries) ->
    Graph = buildGraph(Equations, Values),
    lists:map(fun(Query) -> solveQuery(Query, Graph, []) end, Queries).

buildGraph(Equations, Values) ->
    lists:foldl(fun({[A, B], Value}, Graph) ->
        Graph1 = maps:update_with(A, fun(L) -> [{B, Value} | L] end, [{B, Value}], Graph),
        maps:update_with(B, fun(L) -> [{A, 1.0 / Value} | L] end, [{A, 1.0 / Value}], Graph1)
    end, #{}, lists:zip(Equations, Values)).

solveQuery([Start, End], Graph, Visited) ->
    case (Start == End) of
        true ->
            case maps:is_key(Start, Graph) of
                true -> 1.0;
                false -> -1.0
            end;
        false ->
            solveQueryHelper(Start, End, Graph, Visited, 1.0)
    end.

solveQueryHelper(Start, End, Graph, Visited, Acc) ->
    case maps:is_key(Start, Graph) of
        false ->
            -1.0;
        true ->
            Neighbors = maps:get(Start, Graph),
            solveQueryHelper2(Neighbors, End, Graph, [Start | Visited], Acc)
    end.

solveQueryHelper2([], _, _, _, _) ->
    -1.0;
solveQueryHelper2([{Neighbor, Value} | Rest], End, Graph, Visited, Acc) ->
    case lists:member(Neighbor, Visited) of
        true ->
            solveQueryHelper2(Rest, End, Graph, Visited, Acc);
        false ->
            case (Neighbor == End) of
                true ->
                    Acc * Value;
                false ->
                    Result = solveQueryHelper(Neighbor, End, Graph, [Neighbor | Visited], Acc * Value),
                    case (Result == -1.0) of
                        true ->
                            solveQueryHelper2(Rest, End, Graph, Visited, Acc);
                        false ->
                            Result
                    end
            end
    end.