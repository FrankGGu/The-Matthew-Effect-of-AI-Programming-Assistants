-module(solution).
-export([min_stickers/2]).

min_stickers(Stickers, Target) ->
    TargetCount = count_chars(Target),
    StickerCounts = lists:map(fun count_chars/1, Stickers),
    case can_spell(StickerCounts, TargetCount) of
        false -> -1;
        true ->
            Memo = maps:new(),
            {Result, _} = dfs(StickerCounts, TargetCount, Memo),
            Result
    end.

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Str).

can_spell(StickerCounts, TargetCount) ->
    TargetChars = maps:keys(TargetCount),
    StickerChars = lists:usort(lists:flatten([maps:keys(SC) || SC <- StickerCounts])),
    lists:all(fun(Char) -> lists:member(Char, StickerChars) end, TargetChars).

dfs(StickerCounts, TargetCount, Memo) ->
    case maps:get(TargetCount, Memo, undefined) of
        undefined ->
            case maps:size(TargetCount) of
                0 -> {0, Memo};
                _ ->
                    {Min, NewMemo} = lists:foldl(fun(StickerCount, {CurrentMin, CurrentMemo}) ->
                        NewTargetCount = subtract_counts(TargetCount, StickerCount),
                        case NewTargetCount =/= TargetCount of
                            true ->
                                {Res, UpdatedMemo} = dfs(StickerCounts, NewTargetCount, CurrentMemo),
                                case Res =/= -1 of
                                    true -> {min(CurrentMin, Res + 1), UpdatedMemo};
                                    false -> {CurrentMin, CurrentMemo}
                                end;
                            false -> {CurrentMin, CurrentMemo}
                        end
                    end, {infinity, Memo}, StickerCounts),
                    case Min =:= infinity of
                        true -> {-1, maps:put(TargetCount, -1, Memo)};
                        false -> {Min, maps:put(TargetCount, Min, NewMemo)}
                    end
            end;
        Val -> {Val, Memo}
    end.

subtract_counts(TargetCount, StickerCount) ->
    maps:fold(fun(Char, Count, Acc) ->
        case maps:get(Char, TargetCount, 0) of
            0 -> Acc;
            TargetCountVal ->
                case TargetCountVal - Count =< 0 of
                    true -> maps:remove(Char, Acc);
                    false -> maps:put(Char, TargetCountVal - Count, Acc)
                end
        end
    end, TargetCount, StickerCount).