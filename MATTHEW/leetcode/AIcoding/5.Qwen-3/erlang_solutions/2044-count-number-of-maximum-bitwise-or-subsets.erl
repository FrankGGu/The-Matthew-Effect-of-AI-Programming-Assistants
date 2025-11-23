-module(solution).
-export([count_max_or_subsets/1]).

count_max_or_subsets(Nums) ->
    MaxOr = compute_max_or(Nums),
    count_subsets(Nums, MaxOr, 0, 0).

compute_max_or([]) -> 0;
compute_max_or([H|T]) ->
    OrVal = H bor compute_max_or(T),
    OrVal.

count_subsets([], _Target, _Current, Count) -> Count;
count_subsets([H|T], Target, Current, Count) ->
    NewCurrent = Current bor H,
    case NewCurrent of
        Target ->
            count_subsets(T, Target, NewCurrent, Count + 1);
        _ ->
            count_subsets(T, Target, NewCurrent, Count)
    end,
    count_subsets(T, Target, Current, Count).