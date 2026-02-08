-module(solution).
-export([minStickers/2]).

minStickers(Stickers, Target) ->
    TargetCounts = string_to_counts_tuple(Target),
    StickersCounts = [string_to_counts_tuple(S) || S <- Stickers],

    FilteredStickersCounts = filter_and_deduplicate_stickers(StickersCounts, TargetCounts),

    Memo = maps:new(),
    {Result, _} = dp(TargetCounts, FilteredStickersCounts, Memo),

    case Result of
        infinity -> -1;
        _ -> Result
    end.

string_to_counts_tuple(Str) ->
    lists:foldl(fun(Char, AccTuple) ->
        Index = Char - $a + 1, % 1-indexed for tuple element
        setelement(Index, AccTuple, element(Index, AccTuple) + 1)
    end, list_to_tuple(lists:duplicate(26, 0)), Str).

subtract_counts(Target, Sticker) ->
    list_to_tuple([max(0, element(I, Target) - element(I, Sticker)) || I <- 1..26]).

find_first_non_zero_char_index(Counts) ->
    find_first_non_zero_char_index(Counts, 1).

find_first_non_zero_char_index(Counts, Index) when Index =< 26 ->
    case element(Index, Counts) of
        0 -> find_first_non_zero_char_index(Counts, Index + 1);
        _ -> Index
    end;
find_first_non_zero_char_index(_Counts, _Index) ->
    -1. % All zeros

filter_and_deduplicate_stickers(StickersCounts, TargetCounts) ->
    TargetCharsSet = get_chars_in_counts(TargetCounts),
    UniqueStickers = ordsets:from_list(StickersCounts),
    lists:filter(fun(StickerCount) ->
        StickerCharsSet = get_chars_in_counts(StickerCount),
        not ordsets:is_empty(ordsets:intersection(StickerCharsSet, TargetCharsSet))
    end, UniqueStickers).

get_chars_in_counts(Counts) ->
    lists:foldl(fun(Index, Acc) ->
        case element(Index, Counts) of
            0 -> Acc;
            _ -> ordsets:add(Index - 1, Acc) % Store 0-indexed char index
        end
    end, ordsets:new(), 1..26).

dp(RemainingCounts, AllStickersCounts, Memo) ->
    case find_first_non_zero_char_index(RemainingCounts) of
        -1 -> {0, Memo};
        FirstCharIndex ->
            case maps:find(RemainingCounts, Memo) of
                {ok, Value} -> {Value, Memo};
                _ ->
                    {CalculatedMin, FinalMemo} = 
                        calculate_min_for_state(FirstCharIndex, RemainingCounts, AllStickersCounts, AllStickersCounts, infinity, Memo),

                    NewMemo = maps:put(RemainingCounts, CalculatedMin, FinalMemo),
                    {CalculatedMin, NewMemo}
            end
    end.

calculate_min_for_state(_FirstCharIndex, _RemainingCounts, _AllStickersCounts, [], CurrentMin, Memo) ->
    {CurrentMin, Memo};
calculate_min_for_state(FirstCharIndex, RemainingCounts, AllStickersCounts, [StickerCount | RestStickers], CurrentMin, Memo) ->
    case element(FirstCharIndex, StickerCount) of
        0 -> 
            calculate_min_for_state(FirstCharIndex, RemainingCounts, AllStickersCounts, RestStickers, CurrentMin, Memo);
        _ -> 
            NewRemainingCounts = subtract_counts(RemainingCounts, StickerCount),
            {Res, UpdatedMemoFromSubCall} = dp(NewRemainingCounts, AllStickersCounts, Memo),

            NewMin = case Res of
                         infinity -> CurrentMin;
                         _ -> min(CurrentMin, 1 + Res)
                     end,
            calculate_min_for_state(FirstCharIndex, RemainingCounts, AllStickersCounts, RestStickers, NewMin, UpdatedMemoFromSubCall)
    end.