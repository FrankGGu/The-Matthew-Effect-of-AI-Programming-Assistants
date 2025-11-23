-module(lexicographically_smallest_string_after_applying_operations).
-export([lexicographical_smallest_string/2]).

lexicographical_smallest_string(S, N) ->
    List = string:to_list(S),
    Min = find_min(List, N),
    lists:sublist(Min, length(Min)).

find_min(List, N) ->
    Len = length(List),
    find_min(List, N, 0, Len, []).

find_min(_, _, _, 0, Acc) ->
    Acc;
find_min(List, N, Start, Len, Acc) ->
    NewAcc = case Acc of
        [] -> List;
        _ -> Acc
    end,
    Current = lists:sublist(List, Start + 1, N),
    if
        Start + N > length(List) -> NewAcc;
        true ->
            Swapped = swap(List, Start, Start + N - 1),
            find_min(List, N, Start + 1, Len - 1, min(NewAcc, Swapped))
    end.

swap(List, I, J) ->
    A = lists:sublist(List, I + 1),
    B = lists:sublist(List, I + 1, J - I),
    C = lists:sublist(List, J + 1),
    lists:append(A, lists:reverse(B), C).

min(A, B) ->
    if
        A < B -> A;
        true -> B
    end.