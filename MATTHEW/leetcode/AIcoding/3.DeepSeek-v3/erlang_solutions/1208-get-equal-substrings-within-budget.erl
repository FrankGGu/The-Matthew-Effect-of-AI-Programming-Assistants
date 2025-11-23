-spec equal_substring(S :: unicode:unicode_binary(), T :: unicode:unicode_binary(), MaxCost :: integer()) -> integer().
equal_substring(S, T, MaxCost) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    Costs = lists:zipwith(fun(X, Y) -> abs(X - Y) end, SList, TList),
    equal_substring(Costs, MaxCost, 0, 0, 0, 0).

equal_substring([], _MaxCost, _Left, _Right, _CurrentCost, MaxLen) ->
    MaxLen;
equal_substring([Cost | Rest], MaxCost, Left, Right, CurrentCost, MaxLen) ->
    NewRight = Right + 1,
    NewCurrentCost = CurrentCost + Cost,
    case NewCurrentCost =< MaxCost of
        true ->
            NewMaxLen = max(MaxLen, NewRight - Left),
            equal_substring(Rest, MaxCost, Left, NewRight, NewCurrentCost, NewMaxLen);
        false ->
            NewLeft = Left + 1,
            NewCurrentCost1 = CurrentCost - lists:nth(NewLeft, lists:seq(Left + 1, Right) - Left),
            equal_substring([Cost | Rest], MaxCost, NewLeft, Right, NewCurrentCost1, MaxLen)
    end.