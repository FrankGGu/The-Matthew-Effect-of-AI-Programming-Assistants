-module(nge3).
-export([next_greater_element/1]).

next_greater_element(N) ->
    List = integer_to_list(N),
    Len = length(List),
    Next = lists:seq(0, Len - 1),
    Result = next_greater_element(List, Next, Len),
    case Result of
        false -> -1;
        _ -> list_to_integer(Result)
    end.

next_greater_element(_, [], _) -> false;
next_greater_element(List, [I | Rest], Len) ->
    case find_next_greater(List, I, Len) of
        false -> next_greater_element(List, Rest, Len);
        NextIndex ->
            [A | B] = lists:split(I, List),
            [C | D] = lists:split(NextIndex - I - 1, B),
            [E | F] = lists:split(1, D),
            Sorted = lists:sort(F),
            Result = A ++ C ++ E ++ Sorted,
            Result
    end.

find_next_greater(List, Index, Len) ->
    Value = lists:nth(Index + 1, List),
    find_next_greater(List, Index, Len, Value, []).

find_next_greater(_, _, _, _, []) -> false;
find_next_greater(List, Index, Len, Target, [I | Rest]) ->
    if
        I > Index, lists:nth(I + 1, List) > Target -> I;
        true -> find_next_greater(List, Index, Len, Target, Rest)
    end.