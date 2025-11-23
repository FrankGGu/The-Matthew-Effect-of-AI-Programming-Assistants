-module(matrix_similarity_after_cyclic_shifts).
-export([areSimilar/1]).

areSimilar(Mat) ->
  N = length(Mat),
  case N of
    0 -> true;
    _ ->
      M = length(hd(Mat)),
      lists:all(fun(Row) ->
                    lists:all(fun(K) ->
                                     I = K - 1,
                                     J = (I + K) rem M,
                                     lists:nth(K, Row) =:= lists:nth(J + 1, Row)
                                 end, lists:seq(1, M))
                end, Mat)
  end.