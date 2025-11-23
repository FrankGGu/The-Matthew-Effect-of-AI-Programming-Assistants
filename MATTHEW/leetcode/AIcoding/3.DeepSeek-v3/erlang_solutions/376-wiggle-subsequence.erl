-spec wiggle_max_length(Nums :: [integer()]) -> integer().
wiggle_max_length(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 1;
        _ ->
            {_, _, Len} = lists:foldl(fun
                (Num, {Prev, Dir, Acc}) when Num > Prev, Dir =< 0 ->
                    {Num, 1, Acc + 1};
                (Num, {Prev, Dir, Acc}) when Num < Prev, Dir >= 0 ->
                    {Num, -1, Acc + 1};
                (Num, {_, Dir, Acc}) ->
                    {Num, Dir, Acc}
            end, {hd(Nums), 0, 1}, tl(Nums)),
            Len
    end.