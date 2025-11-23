-module(solution).
-export([magnificent_sets/1]).

magnificent_sets(N, Edges) ->
    G = build_graph(N, Edges),
    case is_bipartite(G, N) of
        false -> -1;
        true -> 
            MaxGroups = lists:max([max_groups(G, Node) || Node <- lists:seq(1, N)]),
            MaxGroups
    end.

build_graph(N, Edges) ->
    G = array:new([{size, N + 1}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
                    UList = array:get(U, Acc),
                    VList = array:get(V, Acc),
                    Acc1 = array:set(U, [V | UList], Acc),
                    array:set(V, [U | VList], Acc1)
                end, G, Edges).

is_bipartite(G, N) ->
    Colors = array:new([{size, N + 1}, {default, -1}]),
    lists:all(fun(Node) ->
                  case array:get(Node, Colors) of
                      -1 -> check_bipartite(G, Node, Colors);
                      _ -> true
                  end
              end, lists:seq(1, N)).

check_bipartite(G, Start, Colors) ->
    Queue = queue:in(Start, queue:new()),
    Colors1 = array:set(Start, 0, Colors),
    check_bipartite_loop(G, Queue, Colors1).

check_bipartite_loop(G, Queue, Colors) ->
    case queue:out(Queue) of
        {empty, _} -> true;
        {{value, U}, Q} ->
            Neighbors = array:get(U, G),
            lists:foldl(fun(V, {QAcc, ColorsAcc, IsValid}) ->
                            case array:get(V, ColorsAcc) of
                                -1 ->
                                    NewColor = 1 - array:get(U, ColorsAcc),
                                    NewColors = array:set(V, NewColor, ColorsAcc),
                                    {queue:in(V, QAcc), NewColors, IsValid};
                                Color ->
                                    if 
                                        Color =:= array:get(U, ColorsAcc) -> 
                                            {QAcc, ColorsAcc, false};
                                        true -> 
                                            {QAcc, ColorsAcc, IsValid}
                                    end
                            end
                        end, {Q, Colors, true}, Neighbors),
            case IsValid of
                false -> false;
                true -> check_bipartite_loop(G, Q1, Colors1)
            end
    end.

max_groups(G, Start) ->
    Visited = array:new([{size, array:size(G)}, {default, -1}]),
    Queue = queue:in({Start, 1}, queue:new()),
    Visited1 = array:set(Start, 1, Visited),
    max_groups_loop(G, Queue, Visited1, 1).

max_groups_loop(G, Queue, Visited, Max) ->
    case queue:out(Queue) of
        {empty, _} -> Max;
        {{value, {U, Level}}, Q} ->
            Neighbors = array:get(U, G),
            {Q1, Visited1, NewMax} = 
                lists:foldl(fun(V, {QAcc, VisitedAcc, CurrentMax}) ->
                                case array:get(V, VisitedAcc) of
                                    -1 ->
                                        NewVisited = array:set(V, Level + 1, VisitedAcc),
                                        {queue:in({V, Level + 1}, QAcc), NewVisited, max(CurrentMax, Level + 1)};
                                    _ ->
                                        {QAcc, VisitedAcc, CurrentMax}
                                end
                            end, {Q, Visited, Max}, Neighbors),
            max_groups_loop(G, Q1, Visited1, NewMax)
    end.