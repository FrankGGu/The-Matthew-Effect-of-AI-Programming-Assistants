-module(smallest_string).
-export([get_smallest_string/2]).

get_smallest_string(N, K) ->
    get_smallest_string(N, K, []).

get_smallest_string(0, _, Acc) ->
    lists:reverse(Acc);
get_smallest_string(N, K, Acc) ->
    MaxPossible := K - (N - 1),
    CharValue := min(MaxPossible, 26),
    get_smallest_string(N - 1, K - CharValue, [CharValue + $a - 1 | Acc]).