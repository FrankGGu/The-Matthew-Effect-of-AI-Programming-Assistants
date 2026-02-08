-spec get_maximum_consecutive(Coins :: [integer()]) -> integer().
get_maximum_consecutive(Coins) ->
    Sorted = lists:sort(Coins),
    get_maximum_consecutive(Sorted, 1, 0).

get_maximum_consecutive([], Max, _Sum) ->
    Max;
get_maximum_consecutive([H | T], Max, Sum) ->
    if
        H =< Sum + 1 ->
            get_maximum_consecutive(T, Max + H, Sum + H);
        true ->
            Max
    end.