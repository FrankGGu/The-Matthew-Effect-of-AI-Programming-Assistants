-module(min_partitions).
-export([min_partitions/1]).

min_partitions(N) ->
  string:to_integer(lists:max(string:tokens(N, ""))).