-module(solution).
-export([minimum_length_of_anagram_concatenation/2]).

char_freq_map(Str) ->
    lists:foldl(fun(Char, Map) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map)
                end, maps:new(), Str).

minimum_length_of_anagram_concatenation(S, K) ->
    N = length(S),

    if N rem K =/= 0 ->
        -1;
    true ->
        L = N div K,

        SubstringsFreqMaps = get_substrings_freq_maps(S, L, K, []),

        case SubstringsFreqMaps of
            [] ->
                -1;
            [FirstMap | RestMaps] ->
                if lists:all(fun(Map) -> Map =:= FirstMap end, RestMaps) ->
                    L;
                true ->
                    -1
                end
        end
    end.

get_substrings_freq_maps(S, L, K, Acc) ->
    if K =:= 0 ->
        lists:reverse(Acc);
    true ->
        Substr = lists:sublist(S, 1, L),
        RestS = lists:nthtail(L, S),
        Map = char_freq_map(Substr),
        get_substrings_freq_maps(RestS, L, K - 1, [Map | Acc])
    end.