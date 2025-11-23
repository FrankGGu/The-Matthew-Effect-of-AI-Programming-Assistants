-module(max_consecutive_ones).
-export([find_max_consecutive_ones/1]).

find_max_consecutive_ones([]) -> 0;
find_max_consecutive_ones([0|T]) -> max(0, find_max_consecutive_ones(T));
find_max_consecutive_ones([1|T]) ->
    1 + find_max_consecutive_ones(T).