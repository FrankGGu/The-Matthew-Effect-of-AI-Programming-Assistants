-module(longest_nice_substring).
-export([longest_nice_substring/1]).

longest_nice_substring(S) ->
    longest_nice_substring(S, 0, 0).

longest_nice_substring(S, Start, MaxLen) ->
    Len = length(S),
    longest_nice_substring(S, 0, Len - 1, Start, MaxLen).

longest_nice_substring(_S, Left, Right, Start, MaxLen) when Left > Right ->
    {Start, MaxLen};
longest_nice_substring(S, Left, Right, Start, MaxLen) ->
    Split = find_bad_char(S, Left, Right),
    case Split of
        none ->
            Len = Right - Left + 1,
            if Len > MaxLen then
                {Left, Len}
            else
                {Start, MaxLen}
            end;
        SplitIndex ->
            {Start1, MaxLen1} = longest_nice_substring(S, Left, SplitIndex - 1, Start, MaxLen),
            {Start2, MaxLen2} = longest_nice_substring(S, SplitIndex + 1, Right, Start1, MaxLen1),
            {Start2, MaxLen2}
    end.

find_bad_char(S, Left, Right) ->
    Chars = string:to_list(S),
    Set = lists:foldl(fun(C, Acc) -> sets:add_element(C, Acc) end, sets:new(), lists:sublist(Chars, Left + 1, Right - Left + 1)),
    find_bad_char(Chars, Left, Right, Set).

find_bad_char(Chars, Left, Right, Set) when Left > Right ->
    none;
find_bad_char(Chars, Left, Right, Set) ->
    C = lists:nth(Left + 1, Chars),
    Other = case C >= $a andalso C =< $z of
                true ->
                    C - 32;
                false ->
                    C + 32
            end,
    case sets:is_element(Other, Set) of
        true ->
            find_bad_char(Chars, Left + 1, Right, Set);
        false ->
            Left + 1
    end.