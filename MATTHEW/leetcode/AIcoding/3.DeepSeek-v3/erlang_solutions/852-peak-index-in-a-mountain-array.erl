-spec peak_index_in_mountain_array(Arr :: [integer()]) -> integer().
peak_index_in_mountain_array(Arr) ->
    peak_index_in_mountain_array(Arr, 1, length(Arr) - 2).

peak_index_in_mountain_array(Arr, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    MidVal = lists:nth(Mid, Arr),
    NextVal = lists:nth(Mid + 1, Arr),
    if
        MidVal < NextVal ->
            peak_index_in_mountain_array(Arr, Mid + 1, Right);
        true ->
            peak_index_in_mountain_array(Arr, Left, Mid - 1)
    end;
peak_index_in_mountain_array(_Arr, Left, _Right) ->
    Left.