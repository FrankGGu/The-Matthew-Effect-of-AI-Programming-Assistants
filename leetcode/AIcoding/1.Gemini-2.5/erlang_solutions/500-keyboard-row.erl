-module(solution).
-export([find_words/1]).

find_words(Words) ->
    Row1 = sets:from_list("qwertyuiopQWERTYUIOP"),
    Row2 = sets:from_list("asdfghjklASDFGHJKL"),
    Row3 = sets:from_list("zxcvbnmZXCVBNM"),

    lists:filter(fun(Word) -> is_one_row(Word, Row1, Row2, Row3) end, Words).

is_one_row([], _, _, _) ->
    true;
is_one_row([H | T], Row1, Row2, Row3) ->
    case {sets:is_element(H, Row1), sets:is_element(H, Row2), sets:is_element(H, Row3)} of
        {true, false, false} -> check_remaining(T, Row1);
        {false, true, false} -> check_remaining(T, Row2);
        {false, false, true} -> check_remaining(T, Row3);
        _ -> false
    end.

check_remaining([], _) ->
    true;
check_remaining([H | T], TargetRow) ->
    sets:is_element(H, TargetRow) andalso check_remaining(T, TargetRow).