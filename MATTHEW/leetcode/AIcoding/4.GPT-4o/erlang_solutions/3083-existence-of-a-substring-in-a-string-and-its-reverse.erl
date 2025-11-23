-module(solution).
-export([is_substring_reverse/2]).

is_substring_reverse(String, Substring) ->
    ReverseSubstring = lists:reverse(Substring),
    case lists:prefix(lists:sublist(String, 0, length(Substring)), Substring) of
        true -> true;
        false -> lists:any(fun(Pos) -> lists:prefix(lists:sublist(String, Pos, length(Substring)), ReverseSubstring) end, lists:seq(1, length(String) - length(Substring) + 1))
    end.