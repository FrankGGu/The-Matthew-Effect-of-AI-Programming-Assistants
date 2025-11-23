-module(solution).
-export([bubble_sort/1]).

bubble_sort([]) -> [];
bubble_sort([H|T]) ->
    {Smaller, Larger} = lists:partition(fun(X) -> X < H end, T),
    bubble_sort(Smaller) ++ [H] ++ bubble_sort(Larger).