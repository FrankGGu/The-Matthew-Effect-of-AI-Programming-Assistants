-module(stickers_to_spell_word).
-export([min_stickers/2]).

min_stickers(Word, Stickers) ->
    WordCount = count_chars(Word),
    StickerCounts = [count_chars(S) || S <- Stickers],
    min_stickers(WordCount, StickerCounts, 0, maps:new()).

min_stickers(_, _, _, Memo) ->
    case maps:is_key(WordCount, Memo) of
        true -> maps:get(WordCount, Memo);
        false ->
            Result = try_min_stickers(WordCount, StickerCounts, 0, Memo),
            maps:put(WordCount, Result, Memo)
    end.

try_min_stickers(WordCount, StickerCounts, Count, Memo) ->
    case is_empty(WordCount) of
        true -> Count;
        false ->
            Min = infinity,
            lists:foldl(
                fun(StickerCount, Acc) ->
                    case can_contribute(WordCount, StickerCount) of
                        true ->
                            NewWordCount = subtract(WordCount, StickerCount),
                            NewCount = min_stickers(NewWordCount, StickerCounts, Count + 1, Memo),
                            if NewCount < Acc -> NewCount; true -> Acc end;
                        false -> Acc
                    end
                end,
                Min,
                StickerCounts
            )
    end.

is_empty(Map) ->
    maps:size(Map) == 0.

can_contribute(WordCount, StickerCount) ->
    maps:keys(WordCount) -- maps:keys(StickerCount) == [].

subtract(WordCount, StickerCount) ->
    maps:fold(
        fun(Char, Count, Acc) ->
            case maps:find(Char, StickerCount) of
                {ok, StickerCount} when StickerCount >= Count ->
                    maps:remove(Char, Acc);
                {ok, StickerCount} when StickerCount < Count ->
                    maps:put(Char, Count - StickerCount, Acc);
                error ->
                    Acc
            end
        end,
        WordCount,
        StickerCount
    ).

count_chars(Str) ->
    lists:foldl(
        fun(Char, Acc) ->
            maps:update_with(Char, fun(C) -> C + 1 end, 1, Acc)
        end,
        maps:new(),
        Str
    ).