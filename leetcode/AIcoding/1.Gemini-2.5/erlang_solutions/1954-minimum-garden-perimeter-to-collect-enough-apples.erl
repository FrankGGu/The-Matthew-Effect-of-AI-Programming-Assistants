-spec minimum_perimeter(NeededApples :: integer()) -> integer().
minimum_perimeter(NeededApples) ->
    Low = 1,
    High = 20000000,
    S = binary_search_s(Low, High, NeededApples, High),
    8 * S.

binary_search_s(Low, High, NeededApples, CurrentMinS) ->
    if
        Low > High ->
            CurrentMinS;
        true ->
            Mid = Low + (High - Low) div 2,
            ApplesCollected = 6 * Mid * (Mid + 1),
            if
                ApplesCollected >= NeededApples ->
                    binary_search_s(Low, Mid - 1, NeededApples, Mid);
                true ->
                    binary_search_s(Mid + 1, High, NeededApples, CurrentMinS)
            end
    end.