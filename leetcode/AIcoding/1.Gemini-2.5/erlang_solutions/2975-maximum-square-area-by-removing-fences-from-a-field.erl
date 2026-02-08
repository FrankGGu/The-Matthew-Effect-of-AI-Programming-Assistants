-module(solution).
-export([maximizeSquareArea/4]).

maximizeSquareArea(M, N, HFences, VFences) ->
    AllHFences = lists:sort(lists:usort([0, M | HFences])),
    AllVFences = lists:sort(lists:usort([0, N | VFences])),

    H_diffs = get_diffs(AllHFences),
    V_diffs = get_diffs(AllVFences),

    CommonDiffs = sets:intersection(H_diffs, V_diffs),

    case sets:is_empty(CommonDiffs) of
        true -> -1;
        false ->
            MaxSide = sets:fold(fun(E, Acc) -> max(E, Acc) end, 0, CommonDiffs),
            MaxSide * MaxSide
    end.

get_diffs(SortedFences) ->
    get_diffs(SortedFences, sets:new()).

get_diffs([], Acc) -> Acc;
get_diffs([H|T], Acc) ->
    NewAcc = lists:foldl(fun(E, CurrentAcc) ->
                             sets:add_element(E - H, CurrentAcc)
                         end, Acc, T),
    get_diffs(T, NewAcc).