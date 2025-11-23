-module(solution).
-export([minimumDeletions/1]).

minimumDeletions(Nums) ->
    N = length(Nums),
    {MinIdx, MaxIdx} = find_min_max_indices_tr(tl(Nums), 1, hd(Nums), 0, hd(Nums), 0),

    A = min(MinIdx, MaxIdx),
    B = max(MinIdx, MaxIdx),

    Strategy1 = B + 1,
    Strategy2 = N - A,
    Strategy3 = (A + 1) + (N - B),

    min(Strategy1, min(Strategy2, Strategy3)).

find_min_max_indices_tr([], _CurrentIdx, MinVal, MinIdx, MaxVal, MaxIdx) ->
    {MinIdx, MaxIdx};
find_min_max_indices_tr([H|T], CurrentIdx, MinVal, MinIdx, MaxVal, MaxIdx) ->
    NewMinVal = min(MinVal, H),
    NewMinIdx = if H < MinVal -> CurrentIdx; true -> MinIdx end,

    NewMaxVal = max(MaxVal, H),
    NewMaxIdx = if H > MaxVal -> CurrentIdx; true -> MaxIdx end,

    find_min_max_indices_tr(T, CurrentIdx + 1, NewMinVal, NewMinIdx, NewMaxVal, NewMaxIdx).