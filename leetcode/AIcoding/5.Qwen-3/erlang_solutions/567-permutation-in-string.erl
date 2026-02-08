-module(permutation_in_string).
-export([check_inclusion/2]).

check_inclusion(Chars, Pattern) ->
    Len = length(Chars),
    PatLen = length(Pattern),
    if
        PatLen > Len -> false;
        true ->
            PatternCount = count_chars(Pattern),
            WindowCount = count_chars(lists:sublist(Chars, PatLen)),
            if
                WindowCount == PatternCount -> true;
                true ->
                    check_window(Chars, PatternCount, WindowCount, PatLen, 1, Len - PatLen)
            end
    end.

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc) end, #{}, Str).

check_window(_, _, _, _, _, 0) -> false;
check_window(Chars, PatternCount, WindowCount, PatLen, Left, Right) ->
    NextChar = lists:nth(Left + PatLen, Chars),
    PrevChar = lists:nth(Left, Chars),
    NewWindowCount = maps:update_with(PrevChar, fun(X) -> X - 1 end, WindowCount),
    NewWindowCount2 = maps:update_with(NextChar, fun(X) -> X + 1 end, NewWindowCount),
    if
        NewWindowCount2 == PatternCount -> true;
        true ->
            check_window(Chars, PatternCount, NewWindowCount2, PatLen, Left + 1, Right - 1)
    end.