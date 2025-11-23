-module(solution).
-export([min_swaps/2]).

min_swaps(S, K) ->
    List = string:to_list(S),
    min_swaps(List, K, 0).

min_swaps(_, 1, Acc) ->
    Acc;
min_swaps(List, K, Acc) ->
    {Smallest, Rest} = find_smallest(List),
    Count = count_swaps(List, Smallest),
    min_swaps(Rest, K-1, Acc + Count).

find_smallest(List) ->
    find_smallest(List, 0, hd(List), 0).

find_smallest([], _Index, Min, MinIndex) ->
    {Min, lists:sublist(List, MinIndex+1, length(List)-MinIndex-1)};
find_smallest([H|T], Index, Min, MinIndex) ->
    if
        H < Min ->
            find_smallest(T, Index+1, H, Index);
        true ->
            find_smallest(T, Index+1, Min, MinIndex)
    end.

count_swaps(List, Char) ->
    count_swaps(List, Char, 0).

count_swaps([], _, Acc) ->
    Acc;
count_swaps([H|T], Char, Acc) ->
    if
        H == Char ->
            Acc;
        true ->
            count_swaps(T, Char, Acc+1)
    end.