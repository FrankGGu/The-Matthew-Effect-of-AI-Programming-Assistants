-module(fuzzy_search).
-export([is_fuzzyMatch/2]).

is_fuzzyMatch(STRING, PATTERN) ->
    is_fuzzyMatch(STRING, PATTERN, 1, 1).

is_fuzzyMatch([], _, _, _) ->
    false;
is_fuzzyMatch(_, [], _, _) ->
    true;
is_fuzzyMatch([S|STR], [P|PAT], SPos, PPos) ->
    case S == P of
        true ->
            is_fuzzyMatch(STR, PAT, SPos + 1, PPos + 1);
        false ->
            case P of
                $* ->
                    is_fuzzyMatch(STR, PAT, SPos + 1, PPos) orelse is_fuzzyMatch(STR, PAT, SPos + 1, PPos + 1);
                _ ->
                    false
            end
    end.