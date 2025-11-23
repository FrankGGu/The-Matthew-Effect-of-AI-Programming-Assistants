-module(frog_position_after_t_seconds).
-export([frogPosition/2]).

frogPosition(Edges, T) ->
    Graph = build_graph(Edges),
    frogPositionHelper(Graph, 1, 0, T, -1).

build_graph(Edges) ->
    lists:foldl(fun({A,B}, Acc) ->
        Acc#{A => maps:get(A, Acc, [] ++ [B]), B => maps:get(B, Acc, [] ++ [A])}
    end, #{}, Edges).

frogPositionHelper(_, _, _, 0, _) ->
    1;
frogPositionHelper(Graph, Node, Time, T, Parent) ->
    Children = maps:get(Node, Graph, []),
    case Children of
        [] ->
            if Time == T -> Node;
               true -> 1
            end;
        _ ->
            NextTime = Time + 1,
            case NextTime > T of
                true -> 1;
                false ->
                    case lists:member(Parent, Children) of
                        true ->
                            NewChildren = lists:delete(Parent, Children),
                            case NewChildren of
                                [] -> 1;
                                _ ->
                                    frogPositionHelper(Graph, lists:nth(1, NewChildren), NextTime, T, Node)
                            end;
                        false ->
                            frogPositionHelper(Graph, lists:nth(1, Children), NextTime, T, Node)
                    end
            end
    end.