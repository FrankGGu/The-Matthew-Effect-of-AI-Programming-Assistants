-module(solution).
-export([findSubstring/2]).

findSubstring(S, Words) ->
    case Words of
        [] -> [];
        [H|_] ->
            WordLen = length(H),
            NumWords = length(Words),
            TotalLen = WordLen * NumWords,
            SLen = length(S),

            if SLen < TotalLen ->
                [];
            true ->
                TargetMap = build_frequency_map(Words),
                lists:flatten([
                    process_offset(S, SLen, WordLen, NumWords, TargetMap, Offset)
                    || Offset <- lists:seq(0, WordLen - 1)
                ])
            end
    end.

build_frequency_map(Words) ->
    lists:foldl(fun(Word, Map) ->
        maps:update_with(Word, fun(Count) -> Count + 1 end, 1, Map)
    end, #{}, Words).

process_offset(S, SLen, WordLen, NumWords, TargetMap, Offset) ->
    process_window(S, SLen, WordLen, NumWords, TargetMap, Offset, [], #{}, Offset, 0).

process_window(S, SLen, WordLen, NumWords, TargetMap, Right, AccResults, CurrentMap, Left, Count) when Right + WordLen =< SLen ->
    Word = lists:sublist(S, Right + 1, WordLen),

    case maps:is_key(Word, TargetMap) of
        true ->
            NewCurrentMap = maps:update_with(Word, fun(C) -> C + 1 end, 1, CurrentMap),
            NewCount = Count + 1,

            {AdjustedCurrentMap, AdjustedLeft, AdjustedCount} =
                shrink_window_from_left(S, WordLen, TargetMap, NewCurrentMap, Left, NewCount),

            case AdjustedCount == NumWords of
                true ->
                    NewAccResults = [AdjustedLeft | AccResults],

                    LeftWord = lists:sublist(S, AdjustedLeft + 1, WordLen),
                    ShrunkCurrentMap = maps:update_with(LeftWord, fun(C) -> C - 1 end, AdjustedCurrentMap),
                    ShrunkLeft = AdjustedLeft + WordLen,
                    ShrunkCount = AdjustedCount - 1,

                    process_window(S, SLen, WordLen, NumWords, TargetMap, Right + WordLen, NewAccResults, ShrunkCurrentMap, ShrunkLeft, ShrunkCount);
                false ->
                    process_window(S, SLen, WordLen, NumWords, TargetMap, Right + WordLen, AccResults, AdjustedCurrentMap, AdjustedLeft, AdjustedCount)
            end;
        false ->
            process_window(S, SLen, WordLen, NumWords, TargetMap, Right + WordLen, AccResults, #{}, Right + WordLen, 0)
    end;
process_window(_S, _SLen, _WordLen, _NumWords, _TargetMap, _Right, AccResults, _CurrentMap, _Left, _Count) ->
    lists:reverse(AccResults).

shrink_window_from_left(S, WordLen, TargetMap, CurrentMap, Left, Count) ->
    LeftWord = lists:sublist(S, Left + 1, WordLen),

    TargetCount = maps:get(LeftWord, TargetMap),
    CurrentWordCount = maps:get(LeftWord, CurrentMap),

    if CurrentWordCount > TargetCount ->
        NewCurrentMap = maps:update_with(LeftWord, fun(C) -> C - 1 end, CurrentMap),
        NewCount = Count - 1,
        shrink_window_from_left(S, WordLen, TargetMap, NewCurrentMap, Left + WordLen, NewCount);
    true ->
        {CurrentMap, Left, Count}
    end.