-module(longest_nice_substring).
-export([longest_nice_substring/1]).

longest_nice_substring(S) ->
    longest_nice_substring(S, 0, erlang:length(S), []).

longest_nice_substring(_, Start, End, Acc) when Start >= End ->
    lists:reverse(Acc);
longest_nice_substring(S, Start, End, Acc) ->
    Sub = string:substr(S, Start + 1, End - Start),
    case is_nice(Sub) of
        true ->
            longest_nice_substring(S, Start + 1, End, [Sub | Acc]);
        false ->
            longest_nice_substring(S, Start + 1, End, Acc)
    end.

is_nice(S) ->
    Set = sets:from_list(string:to_list(S)),
    lists:all(fun(C) -> sets:is_element(C, Set) andalso sets:is_element(upper(C), Set) end, string:to_list(S)).

upper(C) when C >= $a, C =< $z -> C - 32;
upper(C) -> C.