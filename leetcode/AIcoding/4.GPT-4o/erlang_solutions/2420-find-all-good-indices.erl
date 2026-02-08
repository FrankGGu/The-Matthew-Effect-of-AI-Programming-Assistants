-module(solution).
-export([good_indices/2]).

good_indices(A, k) ->
    N = length(A),
    Prefix = lists:duplicate(N, 0),
    Suffix = lists:duplicate(N, 0),
    Prefix = calculate_prefix(A, Prefix, N),
    Suffix = calculate_suffix(A, Suffix, N),
    lists:filter(fun(Index) -> Index >= k, lists:seq(0, N - 1) end),
    lists:filter(fun(Index) -> valid_index(Index, Prefix, Suffix, k) end, lists:seq(k, N - k - 1)).

calculate_prefix([], Prefix, _) ->
    Prefix;
calculate_prefix([H | T], [H | PrefixTail], N) ->
    calculate_prefix(T, PrefixTail, N).

calculate_suffix(A, Suffix, N) ->
    lists:reverse(calculate_prefix(lists:reverse(A), lists:duplicate(N, 0), N)).

valid_index(Index, Prefix, Suffix, K) ->
    Prefix[Index] >= K andalso Suffix[Index] >= K.