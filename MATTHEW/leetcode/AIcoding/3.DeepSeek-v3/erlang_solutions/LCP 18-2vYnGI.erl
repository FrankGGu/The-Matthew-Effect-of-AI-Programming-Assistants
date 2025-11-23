-spec breakfast_number(staple :: [integer()], drinks :: [integer()], x :: integer()) -> integer().
breakfast_number(Staple, Drinks, X) ->
    SortedStaple = lists:sort(Staple),
    SortedDrinks = lists:sort(Drinks),
    Count = 0,
    Mod = 1000000007,
    {Result, _} = lists:foldl(
        fun(S, {Acc, J}) ->
            NewJ = find_max_index(SortedDrinks, X - S, J),
            {(Acc + NewJ) rem Mod, NewJ}
        end,
        {Count, length(SortedDrinks)},
        SortedStaple
    ),
    Result.

find_max_index(List, Max, Start) ->
    find_max_index(List, Max, Start, 0).

find_max_index([], _, _, Acc) ->
    Acc;
find_max_index([H | T], Max, Start, Acc) when H =< Max, Start > 0 ->
    find_max_index(T, Max, Start - 1, Acc + 1);
find_max_index([H | T], Max, Start, Acc) when H =< Max ->
    find_max_index(T, Max, Start, Acc + 1);
find_max_index(_, _, _, Acc) ->
    Acc.