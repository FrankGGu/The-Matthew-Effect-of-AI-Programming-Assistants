-module(solution).
-export([longestPalindrome/1]).

longestPalindrome(S) ->
    CharCounts = lists:foldl(fun(Char, AccMap) ->
                                 Count = maps:get(Char, AccMap, 0),
                                 maps:put(Char, Count + 1, AccMap)
                             end, maps:new(), S),
    {Length, HasOdd} = maps:fold(fun(_Char, Count, {AccLen, AccHasOdd}) ->
                                     NewAccLen = AccLen + (Count div 2 * 2),
                                     NewAccHasOdd = AccHasOdd or (Count rem 2 == 1),
                                     {NewAccLen, NewAccHasOdd}
                                 end, {0, false}, CharCounts),
    case HasOdd of
        true -> Length + 1;
        false -> Length
    end.