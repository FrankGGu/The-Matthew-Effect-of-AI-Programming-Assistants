-module(solution).
-export([max_sequence_value/1]).

max_sequence_value(List) ->
    MaxSeq = lists:foldl(fun(X, Acc) -> max(X, Acc + X) end, 0, List),
    MaxSeq.