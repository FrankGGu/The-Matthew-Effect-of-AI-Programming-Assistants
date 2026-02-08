-module(solution).
-export([arithmeticTriplets/2]).

arithmeticTriplets(Nums, Diff) ->
    Set = gb_sets:from_list(Nums),
    count_triplets(Nums, Diff, Set, 0).

count_triplets([], _Diff, _Set, Count) ->
    Count;
count_triplets([H|T], Diff, Set, Acc) ->
    TargetJ = H + Diff,
    TargetK = H + 2 * Diff,
    case gb_sets:is_member(TargetJ, Set) of
        true ->
            case gb_sets:is_member(TargetK, Set) of
                true ->
                    count_triplets(T, Diff, Set, Acc + 1);
                false ->
                    count_triplets(T, Diff, Set, Acc)
            end;
        false ->
            count_triplets(T, Diff, Set, Acc)
    end.