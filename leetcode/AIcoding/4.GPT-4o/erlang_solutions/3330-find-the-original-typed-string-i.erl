-module(solution).
-export([find_original_string/1]).

find_original_string(typed) ->
    find_original_string(typed, []).

find_original_string([], Result) ->
    lists:reverse(Result);
find_original_string([H | T], Result) ->
    case H of
        $# ->
            case Result of
                [] -> find_original_string(T, Result);
                _ -> find_original_string(T, tl(Result))
            end;
        _ -> find_original_string(T, [H | Result])
    end.