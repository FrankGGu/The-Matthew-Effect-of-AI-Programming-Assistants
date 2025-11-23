-module(solution).
-export([find_nth_value/2]).

find_nth_value(N, K) ->
    Value = (K + 1) div 2,
    K rem 2 + Value + (N - 1) * K.