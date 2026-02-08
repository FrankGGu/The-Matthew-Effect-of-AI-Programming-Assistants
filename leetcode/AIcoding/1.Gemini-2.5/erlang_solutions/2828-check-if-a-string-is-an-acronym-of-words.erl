-module(solution).
-export([is_acronym/2]).

is_acronym(Words, S) ->
    case length(Words) == length(S) of
        false -> false;
        true ->
            check_acronym_chars(Words, S)
    end.

check_acronym_chars([], []) ->
    true;
check_acronym_chars([Word | RestWords], [SChar | RestS]) ->
    case Word of
        [FirstChar | _] when FirstChar == SChar ->
            check_acronym_chars(RestWords, RestS);
        _ ->
            false
    end;
check_acronym_chars(_, _) ->
    false.