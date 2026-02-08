-spec minimum_reserve(Runes :: [integer()]) -> integer().
minimum_reserve(Runes) ->
    Sorted = lists:sort(Runes),
    calculate_min(Sorted, 0, 0).

calculate_min([], _, MaxLen) ->
    MaxLen;
calculate_min([_], _, MaxLen) ->
    MaxLen + 1;
calculate_min([X, Y | Rest], CurrentLen, MaxLen) ->
    if
        Y - X =< 1 ->
            NewCurrentLen = CurrentLen + 1,
            NewMaxLen = max(NewCurrentLen + 1, MaxLen),
            calculate_min([Y | Rest], NewCurrentLen, NewMaxLen);
        true ->
            NewMaxLen = max(CurrentLen + 1, MaxLen),
            calculate_min([Y | Rest], 0, NewMaxLen)
    end.