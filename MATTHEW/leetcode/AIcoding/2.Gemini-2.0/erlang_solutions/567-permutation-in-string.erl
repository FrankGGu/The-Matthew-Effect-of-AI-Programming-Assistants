-module(permutation_in_string).
-export([check_inclusion/2]).

check_inclusion(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    if Len1 > Len2 then
        false
    else
        S1Freq = list_to_map(lists:sort(string:to_list(S1))),
        sliding_window(string:to_list(S2), S1Freq, Len1, Len2)
    end.

sliding_window(S2, S1Freq, Len1, Len2) ->
    case sliding_window(S2, S1Freq, Len1, Len2, 1) of
        true -> true;
        _ -> false
    end.

sliding_window(_S2, _S1Freq, _Len1, _Len2, I) when I + _Len1 - 1 > _Len2 ->
    false;
sliding_window(S2, S1Freq, Len1, _Len2, I) ->
    Sublist = lists:sublist(S2, I, Len1),
    SublistFreq = list_to_map(lists:sort(Sublist)),
    if maps:is_equal(S1Freq, SublistFreq) then
        true
    else
        sliding_window(S2, S1Freq, Len1, _Len2, I + 1)
    end.

list_to_map(List) ->
    list_to_map(List, #{}).

list_to_map([], Map) ->
    Map;
list_to_map([H|T], Map) ->
    case maps:get(H, Map, undefined) of
        undefined ->
            list_to_map(T, maps:put(H, 1, Map));
        Count ->
            list_to_map(T, maps:put(H, Count + 1, Map))
    end.