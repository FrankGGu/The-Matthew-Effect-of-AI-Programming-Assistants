-module(find_maximum_removals).
-export([maximum_removals/3]).

maximum_removals(S, P, Removable) ->
    maximum_removals(S, P, Removable, 0, length(Removable) - 1).

maximum_removals(S, P, Removable, Low, High) ->
    case Low > High of
        true -> Low - 1;
        false ->
            Mid = (Low + High) div 2,
            case is_subsequence_after_removal(S, P, Removable, Mid) of
                true ->
                    maximum_removals(S, P, Removable, Mid + 1, High);
                false ->
                    maximum_removals(S, P, Removable, Low, Mid - 1)
            end
    end.

is_subsequence_after_removal(S, P, Removable, Mid) ->
    Removed_Indices = lists:sublist(Removable, 1, Mid + 1),
    S_Chars = string:to_list(S),
    Filtered_S_Chars = remove_chars_at_indices(S_Chars, Removed_Indices, []),
    is_subsequence(string:to_list(P), lists:reverse(Filtered_S_Chars)).

remove_chars_at_indices(Chars, Indices, Acc) ->
    remove_chars_at_indices(Chars, Indices, 1, Acc).

remove_chars_at_indices([], _, _, Acc) ->
    Acc;
remove_chars_at_indices(Chars, [], _, Acc) ->
    lists:foldl(fun(C, Acc2) -> [C|Acc2] end, Acc, Chars);
remove_chars_at_indices([H|T], [Index|Rest], Current_Index, Acc) ->
    case Index =:= Current_Index of
        true ->
            remove_chars_at_indices(T, Rest, Current_Index + 1, Acc);
        false ->
            remove_chars_at_indices(T, [Index|Rest], Current_Index + 1, [H|Acc])
    end.

is_subsequence([], _) -> true;
is_subsequence(_, []) -> false;
is_subsequence([P_Head|P_Tail], [S_Head|S_Tail]) ->
    case P_Head =:= S_Head of
        true ->
            is_subsequence(P_Tail, S_Tail);
        false ->
            is_subsequence([P_Head|P_Tail], S_Tail)
    end.