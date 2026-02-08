-module(solution).
-export([get_smallest_string/2]).

-spec get_smallest_string(N :: integer(), K :: integer()) -> string().
get_smallest_string(N, K) ->
    get_smallest_string_helper(N, K, []).

get_smallest_string_helper(0, _K, Acc) ->
    lists:reverse(Acc);
get_smallest_string_helper(N, K, Acc) ->
    CharVal = min(26, K - (N - 1)),
    Char = ($a - 1) + CharVal,
    get_smallest_string_helper(N - 1, K - CharVal, [Char | Acc]).