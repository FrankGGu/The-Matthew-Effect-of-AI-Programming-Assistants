-module(solution).
-export([lengthOfLongestSubstring/1]).

lengthOfLongestSubstring(S) ->
    StrList = unicode:characters_to_list(S),
    case length(StrList) of
        0 -> 0;
        _ ->
            IndexedChars = lists:zip(StrList, lists:seq(0, length(StrList) - 1)),
            {_FinalI, _FinalCharMap, MaxLen} = lists:foldl(
                fun({Char, J}, {I, CharMap, CurrentMaxLen}) ->
                    NewI = case maps:find(Char, CharMap) of
                        {ok, PrevIndex} -> max(I, PrevIndex + 1);
                        error -> I
                    end,
                    NewCharMap = maps:put(Char, J, CharMap),
                    NewMaxLen = max(CurrentMaxLen, J - NewI + 1),
                    {NewI, NewCharMap, NewMaxLen}
                end,
                {0, maps:new(), 0},
                IndexedChars
            ),
            MaxLen
    end.