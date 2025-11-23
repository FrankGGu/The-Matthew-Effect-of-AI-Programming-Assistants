-module(remove_nth_from_end).
-export([remove_nth_from_end/2]).

-spec remove_nth_from_end(list(), integer()) -> list().
remove_nth_from_end(List, N) ->
    Len = length(List),
    if N > Len then
        List
    else
        remove_nth_from_end_helper(List, Len - N + 1, 1)
    end.

remove_nth_from_end_helper(List, N, Index) ->
    case List of
        [] -> [];
        [H|T] ->
            if Index == N then
                T
            else
                [H|remove_nth_from_end_helper(T, N, Index + 1)]
            end
    end.