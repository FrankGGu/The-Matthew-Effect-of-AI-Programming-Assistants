-module(max_score).
-export([maximum_score/1]).

maximum_score(S) ->
    maximum_score(string_to_list(S), 0).

maximum_score(S, Acc) ->
    case find_substring(S) of
        {true, NewS, Score} ->
            maximum_score(NewS, Acc + Score);
        false ->
            Acc
    end.

find_substring(S) ->
    find_substring(S, 0, []).

find_substring([], _, Acc) ->
    {false, lists:reverse(Acc), 0}.

find_substring([H|T], State, Acc) ->
    case {H, State} of
        {$a, 0} ->
            find_substring(T, 1, [H|Acc]);
        {$b, 1} ->
            {true, lists:reverse(lists:delete(2, [H|T])), 5};
        {$b, 0} ->
            find_substring(T, 2, [H|Acc]);
        {$a, 2} ->
            {true, lists:reverse(lists:delete(2, [H|T])), 5};
        ({$a, _} = Other, _) when Other /= {$a,0} ->
            find_substring(T, 0, [H|Acc]);
        ({$b, _} = Other, _) when Other /= {$b, 0} ->
             find_substring(T, 0, [H|Acc]);
        _ ->
            find_substring(T, 0, [H|Acc])
    end.