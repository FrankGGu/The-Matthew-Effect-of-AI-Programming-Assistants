-module(solution).
-export([longestPalindrome/1]).

longestPalindrome(S) ->
    StrLen = string:len(S),
    if StrLen < 2 ->
        S;
    true ->
        CharArr = array:from_list(S),
        expand_and_find(CharArr, StrLen, 0, 1, 0)
    end.

expand_and_find(CharArr, StrLen, MaxStart, MaxLen, I) when I < StrLen ->
    if MaxLen >= StrLen - I ->
        lists:sublist(array:to_list(CharArr), MaxStart + 1, MaxLen);
    true ->
        {Len1, Start1} = expand_around_center(CharArr, I, I, StrLen),
        {Len2, Start2} = expand_around_center(CharArr, I, I + 1, StrLen),

        {NewMaxStart1, NewMaxLen1} =
            if Len1 > MaxLen -> {Start1, Len1};
               true          -> {MaxStart, MaxLen}
            end,

        {FinalMaxStart, FinalMaxLen} =
            if Len2 > NewMaxLen1 -> {Start2, Len2};
               true             -> {NewMaxStart1, NewMaxLen1}
            end,

        expand_and_find(CharArr, StrLen, FinalMaxStart, FinalMaxLen, I + 1)
    end;
expand_and_find(CharArr, _StrLen, MaxStart, MaxLen, _I) ->
    lists:sublist(array:to_list(CharArr), MaxStart + 1, MaxLen).

expand_around_center(CharArr, L, R, StrLen) ->
    expand_loop(CharArr, L, R, StrLen).

expand_loop(CharArr, CurrentL, CurrentR, StrLen) ->
    if CurrentL >= 0 andalso CurrentR < StrLen andalso
       array:get(CurrentL, CharArr) == array:get(CurrentR, CharArr) ->
        expand_loop(CharArr, CurrentL - 1, CurrentR + 1, StrLen);
    true ->
        {CurrentR - CurrentL - 1, CurrentL + 1}
    end.