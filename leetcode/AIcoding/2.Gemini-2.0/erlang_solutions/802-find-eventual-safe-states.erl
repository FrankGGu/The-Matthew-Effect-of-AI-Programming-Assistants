-module(safe_states).
-export([eventualSafeNodes/1]).

eventualSafeNodes(Graph) ->
    N = length(Graph),
    Safe = lists:seq(0, N - 1),
    TGraph = transpose(Graph),
    Q = [V || V <- lists:seq(0, N - 1), length(lists:nth(V + 1, Graph)) == 0],
    eventualSafeNodes(Graph, TGraph, Q, Safe, []).

eventualSafeNodes(_, _, [], Safe, Acc) ->
    lists:sort(Acc);
eventualSafeNodes(Graph, TGraph, [U | Rest], Safe, Acc) ->
    Neighbors = lists:nth(U + 1, TGraph),
    NewTGraph = lists:map(fun(V) ->
                                  case lists:member(U, lists:nth(V + 1, Graph)) of
                                      true -> lists:delete(U, lists:nth(V + 1, Graph));
                                      false -> lists:nth(V + 1, Graph)
                                  end
                          end, lists:seq(1, length(Graph))),
    NewQ = [V || V <- Neighbors, length(lists:nth(V + 1, NewTGraph)) == 0, not lists:member(V, Rest)],
    eventualSafeNodes(Graph, transpose(NewTGraph), Rest ++ NewQ, Safe, [U | Acc]).

transpose(Graph) ->
    N = length(Graph),
    lists:map(fun(V) ->
                      [U || U <- lists:seq(0, N - 1), lists:member(V, lists:nth(U + 1, Graph))]
              end, lists:seq(0, N - 1)).