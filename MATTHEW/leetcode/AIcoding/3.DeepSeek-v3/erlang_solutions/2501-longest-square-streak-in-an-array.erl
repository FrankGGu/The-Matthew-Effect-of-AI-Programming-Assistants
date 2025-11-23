-spec longest_square_streak(Nums :: [integer()]) -> integer().
longest_square_streak(Nums) ->
    Sorted = lists:sort(Nums),
    Set = sets:from_list(Sorted),
    MaxStreak = lists:foldl(
        fun(Num, Max) ->
            Streak = count_streak(Num, Set),
            max(Streak, Max)
        end,
        0,
        Sorted
    ),
    if
        MaxStreak >= 2 -> MaxStreak;
        true -> -1
    end.

count_streak(Num, Set) ->
    Square = Num * Num,
    case sets:is_element(Square, Set) of
        true -> 1 + count_streak(Square, Set);
        false -> 1
    end.