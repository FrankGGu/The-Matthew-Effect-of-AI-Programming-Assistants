-module(minimum_remove_to_make_valid_parentheses).
-export([min_remove_to_make_valid/1]).

min_remove_to_make_valid(S) ->
    min_remove_to_make_valid(S, 0, []).

min_remove_to_make_valid([], Acc, Stack) ->
    remove_invalid_from_stack(lists:reverse(Acc), Stack);
min_remove_to_make_valid([C|Rest], Acc, Stack) when C == $( ->
    min_remove_to_make_valid(Rest, [C|Acc], [length(Acc) | Stack]);
min_remove_to_make_valid([C|Rest], Acc, Stack) when C == $) ->
    case Stack of
        [] ->
            min_remove_to_make_valid(Rest, Acc, Stack);
        [Index|RestStack] ->
            min_remove_to_make_valid(Rest, [C|Acc], RestStack)
    end;
min_remove_to_make_valid([C|Rest], Acc, Stack) ->
    min_remove_to_make_valid(Rest, [C|Acc], Stack).

remove_invalid_from_stack(Acc, []) ->
    lists:reverse(Acc);
remove_invalid_from_stack(Acc, [Index|Rest]) ->
    remove_invalid_from_stack(remove_at(Acc, Index), Rest).

remove_at(List, Index) ->
    remove_at(List, Index, 0, []).

remove_at([], _, _, Acc) ->
    lists:reverse(Acc);
remove_at([H|T], Index, CurrentIndex, Acc) ->
    if
        CurrentIndex == Index ->
            lists:reverse(Acc) ++ T;
        true ->
            remove_at(T, Index, CurrentIndex + 1, [H|Acc])
    end.