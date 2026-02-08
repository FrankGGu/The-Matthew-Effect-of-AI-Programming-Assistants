-module(solution).
-export([display_top_k_rows/2]).

display_top_k_rows(Matrix, K) ->
  lists:sublist(Matrix, 1, K).