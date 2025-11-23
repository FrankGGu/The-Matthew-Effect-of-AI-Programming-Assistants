-module(find_duplicate_number).
-export([find_duplicate/1]).

find_duplicate(Numbers) ->
    find_duplicate(Numbers, 1, erlang:length(Numbers) - 1).

find_duplicate(Numbers, Left, Right) ->
    case Left >= Right of
        true -> Left;
        false ->
            Mid = (Left + Right) div 2,
            Count = count_less_equal(Numbers, Mid),
            if
                Count > Mid -> find_duplicate(Numbers, Left, Mid);
                true -> find_duplicate(Numbers, Mid + 1, Right)
            end
    end.

count_less_equal([], _), -> 0;
count_less_equal([H | T], Target) ->
    if
        H =< Target -> 1 + count_less_equal(T, Target);
        true -> count_less_equal(T, Target)
    end.