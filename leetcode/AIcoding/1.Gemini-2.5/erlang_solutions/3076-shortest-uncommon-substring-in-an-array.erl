-module(solution).
-export([shortest_uncommon_substring/1]).

shortest_uncommon_substring(Words) ->
    SubstringsMap = build_substrings_map(Words, 0, #{}),

    UncommonSubstrings = maps:fold(
        fun(Sub, WordIndicesSet, AccList) ->
            if sets:size(WordIndicesSet) == 1 ->
                [Sub | AccList];
            true ->
                AccList
            end
        end,
        [],
        SubstringsMap
    ),

    case UncommonSubstrings of
        [] ->
            "";
        _ ->
            Sorted = lists:sort(
                fun(A, B) ->
                    LenA = length(A),
                    LenB = length(B),
                    if LenA < LenB -> true;
                       LenA > LenB -> false;
                       true -> A < B
                    end
                end,
                UncommonSubstrings
            ),
            hd(Sorted)
    end.

build_substrings_map(Words, WordIdx, AccMap) when WordIdx < length(Words) ->
    CurrentWord = lists:nth(WordIdx + 1, Words),
    CurrentWordSubstrings = get_all_substrings(CurrentWord),
    UpdatedMap = sets:fold(
        fun(Sub, Map) ->
            CurrentSet = maps:get(Sub, Map, sets:new()),
            UpdatedSet = sets:add_element(WordIdx, CurrentSet),
            maps:put(Sub, UpdatedSet, Map)
        end,
        AccMap,
        CurrentWordSubstrings
    ),
    build_substrings_map(Words, WordIdx + 1, UpdatedMap);
build_substrings_map(_Words, _WordIdx, AccMap) ->
    AccMap.

get_all_substrings(Word) ->
    Len = length(Word),
    lists:foldl(
        fun(Start, AccSet) ->
            lists:foldl(
                fun(End, InnerAccSet) ->
                    Sub = lists:sublist(Word, Start, End - Start + 1),
                    sets:add_element(Sub, InnerAccSet)
                end,
                AccSet,
                lists:seq(Start, Len)
            )
        end,
        sets:new(),
        lists:seq(1, Len)
    ).