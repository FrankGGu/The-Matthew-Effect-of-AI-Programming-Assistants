-spec max_divisor_score(Nums :: [integer()], Divisors :: [integer()]) -> integer().
max_divisor_score(Nums, Divisors) ->
    Scores = lists:foldl(
        fun(Divisor, Acc) ->
            Count = lists:foldl(
                fun(Num, Cnt) ->
                    case Num rem Divisor of
                        0 -> Cnt + 1;
                        _ -> Cnt
                    end
                end,
                0,
                Nums
            ),
            [{Count, Divisor} | Acc]
        end,
        [],
        Divisors
    ),
    Sorted = lists:sort(
        fun({Cnt1, Div1}, {Cnt2, Div2}) ->
            if
                Cnt1 > Cnt2 -> true;
                Cnt1 < Cnt2 -> false;
                true -> Div1 < Div2
            end
        end,
        Scores
    ),
    case Sorted of
        [] -> 0;
        [{_, Div} | _] -> Div
    end.