-module(minimum_string_length_after_removing_substrings).
-export([minLength/1]).

minLength(S) ->
    do_remove(S).

do_remove(S) ->
    case string:find(S, "AB") of
        {match, _} ->
            do_remove(string:substr(S, 1, 0) ++ string:substr(S, 3));
        nomatch ->
            case string:find(S, "BA") of
                {match, _} ->
                    do_remove(string:substr(S, 1, 0) ++ string:substr(S, 3));
                nomatch ->
                    S
            end
    end.