-module(maximum_score_node_sequence).
-export([maximum_score/2]).

maximum_score(Scores, Edges) ->
  N = length(Scores),
  Adj = create_adjacency_list(N, Edges),
  max_score(N, Scores, Adj).

create_adjacency_list(N, Edges) ->
  lists:foldl(fun({U, V}, Acc) ->
                Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                      V => lists:append(maps:get(V, Acc, []), [U])}
              end, #{}, Edges).

max_score(N, Scores, Adj) ->
  max_score_helper(N, Scores, Adj, 0).

max_score_helper(N, Scores, Adj, MaxSoFar) ->
  case find_quadruples(N, Scores, Adj) of
    [] ->
      MaxSoFar;
    Quadruples ->
      MaxScore = lists:max([score_quadruple(Quadruple, Scores) || Quadruple <- Quadruples]),
      max_score_helper(N, Scores, Adj, max(MaxSoFar, MaxScore))
  end.

find_quadruples(N, Scores, Adj) ->
  lists:foldl(fun(A, Acc) ->
                lists:foldl(fun(B, Acc2) ->
                              case A < B of
                                true ->
                                  lists:foldl(fun(C, Acc3) ->
                                                case B < C andalso lists:member(C, maps:get(A, Adj, [])) =:= false of
                                                  true ->
                                                    lists:foldl(fun(D, Acc4) ->
                                                                  case C < D andalso lists:member(D, maps:get(A, Adj, [])) =:= false andalso lists:member(D, maps:get(B, Adj, [])) =:= false andalso lists:member(D, maps:get(C, Adj, [])) =:= false of
                                                                    true ->
                                                                      case lists:member(B, maps:get(A, Adj, [])) andalso lists:member(C, maps:get(B, Adj, [])) andalso lists:member(D, maps:get(C, Adj, [])) of
                                                                        true ->
                                                                          [ {A, B, C, D} | Acc4];
                                                                        false ->
                                                                          Acc4
                                                                      end;
                                                                    false ->
                                                                      Acc4
                                                                  end, Acc3, lists:seq(1, N));
                                                  false ->
                                                    Acc3
                                                end, Acc2, lists:seq(1, N));
                                false ->
                                  Acc2
                              end, Acc, maps:get(A, Adj, []));
              end, [], lists:seq(1, N)).

score_quadruple({A, B, C, D}, Scores) ->
  lists:nth(A, Scores) + lists:nth(B, Scores) + lists:nth(C, Scores) + lists:nth(D, Scores).