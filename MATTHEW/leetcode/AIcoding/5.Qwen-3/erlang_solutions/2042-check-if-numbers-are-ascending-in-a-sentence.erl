-module(solution).
-export([are_numbers_ascending/1]).

are_numbers_ascending(Sentence) ->
    Words = string:split(Sentence, " "),
    Numbers = lists:filter(fun(W) -> is_number(W) end, Words),
    IsAscending = check_ascending(Numbers, 0),
    IsAscending.

is_number(Str) ->
    case string:to_integer(Str) of
        {error, _} -> false;
        _ -> true
    end.

check_ascending([], _) -> true;
check_ascending([H|T], Prev) ->
    case string:to_integer(H) of
        {Int, _} when Int > Prev ->
            check_ascending(T, Int);
        _ ->
            false
    end.