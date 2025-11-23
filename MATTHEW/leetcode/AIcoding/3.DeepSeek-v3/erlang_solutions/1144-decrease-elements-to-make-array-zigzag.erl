-spec moves_to_make_zigzag(Nums :: [integer()]) -> integer().
moves_to_make_zigzag(Nums) ->
    {Even, Odd} = lists:foldl(fun(Idx, {EvenAcc, OddAcc}) ->
        Left = case Idx - 1 of
                   Neg when Neg < 0 -> infinity;
                   Pos -> lists:nth(Pos + 1, Nums)
               end,
        Right = case Idx + 1 of
                    Over when Over >= length(Nums) -> infinity;
                    Under -> lists:nth(Under + 1, Nums)
                end,
        Min = min(Left, Right),
        Current = lists:nth(Idx + 1, Nums),
        Diff = max(0, Current - Min + 1),
        case Idx rem 2 of
            0 -> {EvenAcc + Diff, OddAcc};
            1 -> {EvenAcc, OddAcc + Diff}
        end
    end, {0, 0}, lists:seq(0, length(Nums) - 1)),
    min(Even, Odd).