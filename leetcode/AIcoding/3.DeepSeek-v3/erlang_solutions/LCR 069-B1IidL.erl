-spec peak_index_in_mountain_array(Arr :: [integer()]) -> integer().
peak_index_in_mountain_array(Arr) ->
    PeakIndex = find_peak(Arr, 0, length(Arr) - 1),
    PeakIndex.

find_peak(Arr, Left, Right) ->
    Mid = Left + (Right - Left) div 2,
    case (Mid > 0 andalso lists:nth(Mid, Arr) > lists:nth(Mid + 1, Arr)) andalso
         (Mid < length(Arr) - 1 andalso lists:nth(Mid, Arr) > lists:nth(Mid - 1, Arr)) of
        true -> Mid;
        false ->
            if
                lists:nth(Mid, Arr) < lists:nth(Mid + 1, Arr) ->
                    find_peak(Arr, Mid + 1, Right);
                true ->
                    find_peak(Arr, Left, Mid - 1)
            end
    end.