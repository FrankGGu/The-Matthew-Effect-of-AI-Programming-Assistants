-module(solution).
-export([isSubstringPresent/1]).

isSubstringPresent(S) ->
    Reverse = lists:reverse(S),
    is_substring(S, Reverse).

is_substring([], _) -> false;
is_substring(_, []) -> false;
is_substring(S, Rev) ->
    case lists:member(string:substr(S, 1, 2), Rev) of
        true -> true;
        _ -> is_substring(tl(S), Rev)
    end.