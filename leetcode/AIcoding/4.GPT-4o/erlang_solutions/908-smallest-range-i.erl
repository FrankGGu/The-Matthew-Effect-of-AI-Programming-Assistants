-module(solution).
-export([smallest_range_i/2]).

smallest_range_i(A, K) ->
    Min = lists:min(A),
    Max = lists:max(A),
    Max - Min - 2 * K /|> lists:max(0).