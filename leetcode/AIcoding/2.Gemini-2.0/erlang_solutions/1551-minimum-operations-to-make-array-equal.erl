-module(minimum_operations).
-export([min_operations/1]).

min_operations(N) ->
  (N * N) div 4.