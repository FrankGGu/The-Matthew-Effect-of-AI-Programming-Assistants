-module(solution).
-export([strStr/2]).

-spec strStr(Haystack :: unicode:unicode_binary(), Needle :: unicode:unicode_binary()) -> integer().
strStr(Haystack, Needle) ->
    case binary:match(Haystack, Needle) of
        [{Start, _Length}] ->
            Start;
        nomatch ->
            -1
    end.