-module(solution).
-export([longestPalindrome/1]).

longestPalindrome(Words) ->
    Counts = lists:foldl(
        fun(Word, AccMap) ->
            maps:update_with(Word, fun(Cnt) -> Cnt + 1 end, 1, AccMap)
        end,
        maps:new(),
        Words
    ),

    {TotalLength, HasCenter} = maps:fold(
        fun(Word, Count, {AccLen, AccCenter}) ->
            C1 = hd(Word),
            C2 = hd(tl(Word)),

            if C1 == C2 ->
                Pairs = Count div 2,
                NewLen = AccLen + Pairs * 4,
                NewCenter = AccCenter orelse (Count rem 2 == 1),
                {NewLen, NewCenter};
            true ->
                if C1 < C2 ->
                    RevWord = [C2, C1],
                    RevCount = maps:get(RevWord, Counts, 0),

                    Pairs = min(Count, RevCount),
                    NewLen = AccLen + Pairs * 4,
                    {NewLen, AccCenter};
                true ->
                    {AccLen, AccCenter}
                end
            end
        end,
        {0, false},
        Counts
    ),

    if HasCenter ->
        TotalLength + 2;
    true ->
        TotalLength
    end.