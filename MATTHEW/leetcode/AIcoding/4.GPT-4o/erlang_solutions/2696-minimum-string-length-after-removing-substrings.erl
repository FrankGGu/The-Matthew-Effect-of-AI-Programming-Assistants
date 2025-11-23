-module(solution).
-export([minimum_length_after_removing_substrings/2]).

minimum_length_after_removing_substrings(String, Substring) ->
    loop(String, Substring).

loop(String, Substring) ->
    case lists:prefix(String, Substring) orelse lists:prefix(lists:reverse(String), lists:reverse(Substring)) of
        true ->
            NewString = remove_substring(String, Substring),
            loop(NewString, Substring);
        false ->
            length(String)
    end.

remove_substring(String, Substring) ->
    lists:foldl(fun(_, Acc) -> lists:filter(fun(X) -> X =/= hd(Substring) end, Acc) end, String, Substring).