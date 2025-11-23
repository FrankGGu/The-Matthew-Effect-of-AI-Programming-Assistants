-module(next_permutation).
-export([next_permutation/1]).

next_permutation(List) ->
    Len = length(List),
    I = find_i(List, Len - 1, -1),
    if
        I == -1 ->
            List;
        true ->
            J = find_j(List, I, Len - 1),
            swap(List, I, J),
            reverse(List, I + 1, Len - 1)
    end.

find_i(_, _, -1) -> -1;
find_i(List, I, K) ->
    case lists:nth(I, List) < lists:nth(I+1, List) of
        true -> I;
        false -> find_i(List, I-1, K)
    end.

find_j(List, I, J) ->
    if
        lists:nth(J, List) > lists:nth(I, List) -> J;
        true -> find_j(List, I, J-1)
    end.

swap(List, I, J) ->
    A = lists:nth(I+1, List),
    B = lists:nth(J+1, List),
    lists:sublist(List, I) ++ [B] ++ lists:sublist(List, I+2, J - I -1) ++ [A] ++ lists:sublist(List, J+2).

reverse(List, Start, End) ->
    Left = lists:sublist(List, Start),
    Middle = lists:sublist(List, Start, End - Start + 1),
    Right = lists:sublist(List, End + 1),
    Left ++ lists:reverse(Middle) ++ Right.