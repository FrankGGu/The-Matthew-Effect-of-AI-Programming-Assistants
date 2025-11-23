-module(longest_palindrome_after_substring_concatenation).
-export([longest_palindromic_substring/1]).

longest_palindromic_substring(S) ->
    case S of
        [] -> "";
        _ ->
            N = length(S),
            MaxLen = 0,
            Start = 0,
            lists:foldl(fun(I, {MaxLenAcc, StartAcc}) ->
                            {Len1, Start1} = expand_around_center(S, I, I),
                            {Len2, Start2} = expand_around_center(S, I, I + 1),
                            MaxLenNew = max(Len1, Len2),
                            if
                                MaxLenNew > MaxLenAcc ->
                                    {MaxLenNew, Start1};
                                true ->
                                    {MaxLenAcc, StartAcc}
                            end
                        end, {MaxLen, Start}, lists:seq(0, N - 1)),
            [Start | _] = lists:seq(Start, Start + MaxLen - 1),
            substring(S, Start, MaxLen)
    end.

expand_around_center(S, Left, Right) ->
    N = length(S),
    while Left >= 0 andalso Right < N andalso (lists:nth(Left + 1, S) == lists:nth(Right + 1, S)) do
        Left := Left - 1,
        Right := Right + 1
    end,
    {Right - Left - 1, Left + 1}.

substring(S, Start, Length) ->
    lists:sublist(S, Start + 1, Length).