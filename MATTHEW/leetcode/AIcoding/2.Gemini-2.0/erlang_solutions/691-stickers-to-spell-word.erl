-module(stickers_to_spell_word).
-export([minStickers/2]).

minStickers(Stickers, Target) ->
    Len = length(Target),
    Cache = dict:new(),
    minStickersHelper(Stickers, Target, Cache, Len).

minStickersHelper(Stickers, "", Cache, _) ->
    0;
minStickersHelper(Stickers, Target, Cache, Len) ->
    case dict:find(Target, Cache) of
        {ok, Result} ->
            Result;
        error ->
            Result = 
                lists:foldl(
                    fun(Sticker, Acc) ->
                        NewTarget = removeChars(Target, Sticker),
                        if
                            NewTarget == Target ->
                                Acc;
                            true ->
                                StickersUsed = minStickersHelper(Stickers, NewTarget, Cache, Len),
                                if
                                    StickersUsed == -1 ->
                                        Acc;
                                    true ->
                                        min(Acc, StickersUsed + 1)
                                end
                        end
                    end,
                    infinity,
                    Stickers
                ),
            FinalResult = if Result == infinity -> -1; true -> Result end,
            dict:store(Target, FinalResult, Cache),
            FinalResult
    end.

removeChars(Target, Sticker) ->
    removeCharsHelper(Target, Sticker, []).

removeCharsHelper("", _, Acc) ->
    lists:reverse(Acc);
removeCharsHelper(Target, "", Acc) ->
    lists:reverse(Acc) ++ string:to_list(Target);
removeCharsHelper([H|T], Sticker, Acc) ->
    case string:chr(Sticker, H) of
        0 ->
            removeCharsHelper(T, Sticker, [H|Acc]);
        Pos ->
            NewSticker = string:substr(Sticker, 1, Pos - 1) ++ string:substr(Sticker, Pos + 1, length(Sticker) - Pos),
            removeCharsHelper(T, NewSticker, Acc)
    end.