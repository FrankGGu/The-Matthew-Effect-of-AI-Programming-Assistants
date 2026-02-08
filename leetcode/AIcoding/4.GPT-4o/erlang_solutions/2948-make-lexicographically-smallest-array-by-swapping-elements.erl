-module(solution).
-export([lexicographically_smallest/1]).

lexicographically_smallest(List) ->
    Sorted = lists:sort(List),
    swap_elements(List, Sorted, []).

swap_elements([], [], Acc) -> 
    lists:reverse(Acc);
swap_elements([H1 | T1], [H2 | T2], Acc) when H1 =:= H2 -> 
    swap_elements(T1, T2, [H1 | Acc]);
swap_elements([H1 | T1], [H2 | T2], Acc) -> 
    swap_elements(T1, [H2 | T2], [H1 | Acc]).