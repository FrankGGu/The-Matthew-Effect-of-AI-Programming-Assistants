-module(distinct_subsequences).
-export([num_distinct/1]).

num_distinct(S) ->
    num_distinct(S, 0, 1, #{}).

num_distinct([], _, Count, _) ->
    Count;
num_distinct([C | T], Index, Count, Map) ->
    NewCount = (Count * 2) - maps:get(C, Map, 0),
    num_distinct(T, Index + 1, NewCount rem 1000000007, maps:put(C, Count, Map)).