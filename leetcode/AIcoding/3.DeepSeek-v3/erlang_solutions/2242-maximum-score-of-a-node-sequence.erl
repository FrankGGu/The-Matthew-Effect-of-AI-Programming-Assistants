-module(solution).
-export([maximum_score/2]).

maximum_score(Scores, Edges) ->
    N = length(Scores),
    Graph = lists:foldl(fun([U, V], Acc) ->
                            U1 = U + 1,
                            V1 = V + 1,
                            Acc1 = case maps:find(U1, Acc) of
                                      {ok, Neighs} -> maps:put(U1, [V1 | Neighs], Acc);
                                      error -> maps:put(U1, [V1], Acc)
                                   end,
                            case maps:find(V1, Acc1) of
                                {ok, Neighs1} -> maps:put(V1, [U1 | Neighs1], Acc1);
                                error -> maps:put(V1, [U1], Acc1)
                            end
                        end, maps:new(), Edges),
    MaxScore = -1,
    maps:fold(fun(Node, Neighs, Acc) ->
                 case length(Neighs) >= 2 of
                     true ->
                         SortedNeighs = lists:sort(fun(A, B) ->
                                                         lists:nth(A, Scores) > lists:nth(B, Scores)
                                                     end, Neighs),
                         TopNeighs = lists:sublist(SortedNeighs, min(3, length(SortedNeighs))),
                         find_max_sequence(Node, TopNeighs, Scores, Graph, Acc);
                     false ->
                         Acc
                 end
             end, MaxScore, Graph).

find_max_sequence(Node, Neighs, Scores, Graph, MaxScore) ->
    Len = length(Neighs),
    lists:foldl(fun(I, Acc) ->
                    lists:foldl(fun(J, Acc1) ->
                                    if
                                        I /= J ->
                                            A = lists:nth(I, Neighs),
                                            B = lists:nth(J, Neighs),
                                            case maps:find(B, Graph) of
                                                {ok, BNeighs} ->
                                                    case lists:member(A, BNeighs) of
                                                        true ->
                                                            Score = lists:nth(Node, Scores) + lists:nth(A, Scores) + lists:nth(B, Scores) + lists:nth(A, Scores),
                                                            max(Score, Acc1);
                                                        false ->
                                                            Acc1
                                                    end;
                                                error ->
                                                    Acc1
                                            end;
                                        true ->
                                            Acc1
                                    end
                                end, Acc, lists:seq(1, Len))
                end, MaxScore, lists:seq(1, Len)).