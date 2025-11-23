-module(solution).
-export([minimize_max_difference/2]).

minimize_max_difference(Nums, P) ->
    SortedNums = lists:sort(Nums),
    Min = 0,
    Max = lists:last(SortedNums) - lists:first(SortedNums),
    binary_search(SortedNums, P, Min, Max).

binary_search(SortedNums, P, Left, Right) ->
    case Left >= Right of
        true -> Left;
        false ->
            Mid = (Left + Right) div 2,
            if
                can_form_pairs(SortedNums, Mid, P) ->
                    binary_search(SortedNums, P, Left, Mid);
                true ->
                    binary_search(SortedNums, P, Mid + 1, Right)
            end
    end.

can_form_pairs(SortedNums, MaxDiff, P) ->
    N = length(SortedNums),
    {Pairs, _} = lists:foldl(fun(X, {Acc, Last}) ->
        case Acc of
            0 -> {0, X};
            _ when X - Last > MaxDiff -> {Acc - 1, X};
            _ -> {Acc, Last}
        end
    end, {P, hd(SortedNums)}, tl(SortedNums)),
    Pairs >= 0.