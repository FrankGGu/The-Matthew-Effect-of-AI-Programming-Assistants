-spec number_of_arithmetic_slices(Nums :: [integer()]) -> integer().
number_of_arithmetic_slices(Nums) ->
    case length(Nums) < 3 of
        true -> 0;
        false ->
            {_, _, Total} = lists:foldl(fun
                (Num, {Prev, Diff, Count, Acc}) ->
                    case Num - Prev of
                        Diff ->
                            NewCount = Count + 1,
                            {Num, Diff, NewCount, Acc + NewCount};
                        NewDiff ->
                            {Num, NewDiff, 1, Acc}
                    end
                end,
                {hd(tl(Nums)), hd(tl(Nums)) - hd(Nums), 1, 0},
                tl(tl(Nums))),
            Total
    end.