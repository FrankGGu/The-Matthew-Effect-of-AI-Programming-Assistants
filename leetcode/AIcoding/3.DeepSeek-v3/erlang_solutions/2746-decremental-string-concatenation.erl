-module(solution).
-export([minimize_concatenation_cost/1]).

minimize_concatenation_cost(Words) ->
    {Cost, _} = dp(Words, #{}),
    Cost.

dp([], _) -> {0, {0, 0}};
dp([Word | Rest], Memo) ->
    case maps:get(Word, Memo, undefined) of
        undefined ->
            {RestCost, {FirstChar, LastChar}} = dp(Rest, Memo),
            CurrentFirst = hd(Word),
            CurrentLast = lists:last(Word),
            NewCost = case RestCost of
                0 -> 0;
                _ -> 
                    case LastChar == CurrentFirst of
                        true -> RestCost + 1;
                        false -> RestCost
                    end
            end,
            NewMemo = maps:put(Word, {NewCost, {CurrentFirst, CurrentLast}}, Memo),
            {NewCost, {CurrentFirst, CurrentLast}};
        {CachedCost, {CachedFirst, CachedLast}} ->
            {CachedCost, {CachedFirst, CachedLast}}
    end.