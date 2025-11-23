-spec contains_nearby_almost_duplicate(Nums :: [integer()], IndexDiff :: integer(), ValueDiff :: integer()) -> boolean().
contains_nearby_almost_duplicate(Nums, IndexDiff, ValueDiff) ->
    contains_nearby_almost_duplicate(Nums, IndexDiff, ValueDiff, []).

contains_nearby_almost_duplicate([], _, _, _) -> false;
contains_nearby_almost_duplicate([H | T], IndexDiff, ValueDiff, Window) ->
    contains_nearby_almost_duplicate(T, IndexDiff, ValueDiff, [H | Window]);

contains_nearby_almost_duplicate([H | T], IndexDiff, ValueDiff, [W | Window]) when length(Window) >= IndexDiff ->
    if
        abs(H - W) =< ValueDiff -> true;
        true -> contains_nearby_almost_duplicate(T, IndexDiff, ValueDiff, tl(Window))
    end.

contains_nearby_almost_duplicate([H | T], IndexDiff, ValueDiff, Window) ->
    contains_nearby_almost_duplicate(T, IndexDiff, ValueDiff, [H | Window]).
