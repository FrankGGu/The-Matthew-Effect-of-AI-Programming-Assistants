-module(longest_palindromic_substring).
-export([longestPalindrome/1]).

longestPalindrome(S) ->
    case S of
        [] -> "";
        _ ->
            Len = length(S),
            {Start, End} = lists:foldl(fun(I, {MaxStart, MaxEnd}) ->
                {Left1, Right1} = expandAroundCenter(S, I, I),
                {Left2, Right2} = expandAroundCenter(S, I, I + 1),
                {NewStart, NewEnd} = if
                    (Right1 - Left1) > (MaxEnd - MaxStart) -> {Left1, Right1};
                    (Right2 - Left2) > (MaxEnd - MaxStart) -> {Left2, Right2};
                    true -> {MaxStart, MaxEnd}
                end,
                {NewStart, NewEnd}
            end, {0, 0}, lists:seq(0, Len - 1)),
            substring(S, Start, End + 1)
    end.

expandAroundCenter(S, Left, Right) ->
    while Left >= 0 andalso Right < length(S) andalso (lists:nth(Left + 1, S) == lists:nth(Right + 1, S)) do
        Left := Left - 1,
        Right := Right + 1
    end,
    {Left + 1, Right - 1}.

substring(S, Start, End) ->
    lists:sublist(S, Start + 1, End - Start).