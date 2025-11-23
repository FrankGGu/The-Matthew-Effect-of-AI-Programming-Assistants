-spec maxmium_score(Cards :: [integer()], Cnt :: integer()) -> integer().
maxmium_score(Cards, Cnt) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Cards),
    {Sum, Odd, Even} = lists:foldl(fun(Card, {AccSum, AccOdd, AccEven}) ->
        NewSum = AccSum + Card,
        case Card rem 2 of
            1 -> {NewSum, [Card | AccOdd], AccEven};
            0 -> {NewSum, AccOdd, [Card | AccEven]}
        end
    end, {0, [], []}, lists:sublist(Sorted, Cnt)),
    case Sum rem 2 of
        0 -> Sum;
        1 ->
            case {Odd, Even} of
                {[], _} -> 0;
                {_, []} -> 0;
                {[H1 | T1], [H2 | T2]} ->
                    Option1 = case T2 of [] -> 0; _ -> Sum - H1 + hd(T2) end,
                    Option2 = case T1 of [] -> 0; _ -> Sum - H2 + hd(T1) end,
                    max(Option1, Option2)
            end
    end.