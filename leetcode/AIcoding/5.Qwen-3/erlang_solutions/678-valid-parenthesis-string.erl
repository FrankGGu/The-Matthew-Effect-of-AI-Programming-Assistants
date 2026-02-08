-module(valid_parenthesis_string).
-export([check_valid_string/1]).

check_valid_string(S) ->
    check_valid_string(S, 0).

check_valid_string([], Count) ->
    Count == 0;
check_valid_string([H | T], Count) ->
    case H of
        $* ->
            check_valid_string(T, Count + 1) orelse check_valid_string(T, Count - 1) orelse check_valid_string(T, Count);
        $( ->
            check_valid_string(T, Count + 1);
        $) ->
            if
                Count > 0 -> check_valid_string(T, Count - 1);
                true -> false
            end
    end.