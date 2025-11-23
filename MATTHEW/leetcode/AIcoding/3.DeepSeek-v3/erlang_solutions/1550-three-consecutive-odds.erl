-spec three_consecutive_odds(Arr :: [integer()]) -> boolean().
three_consecutive_odds(Arr) ->
    three_consecutive_odds(Arr, 0).

three_consecutive_odds([], Count) ->
    Count >= 3;
three_consecutive_odds([H | T], Count) when H rem 2 =:= 1 ->
    case Count + 1 of
        3 -> true;
        NewCount -> three_consecutive_odds(T, NewCount)
    end;
three_consecutive_odds([_ | T], _) ->
    three_consecutive_odds(T, 0).