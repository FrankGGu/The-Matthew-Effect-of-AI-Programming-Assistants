-spec max_strength(Nums :: [integer()]) -> integer().
max_strength(Nums) ->
    case Nums of
        [] -> 0;
        [X] -> X;
        _ ->
            Positives = [X || X <- Nums, X > 0],
            Negatives = [X || X <- Nums, X < 0],
            case {Positives, Negatives} of
                {[], []} -> 0;
                {[], [_]} -> lists:max(Nums);
                {[], Negs} ->
                    SortedNegs = lists:sort(Negs),
                    case length(SortedNegs) rem 2 of
                        0 -> lists:foldl(fun(X, Acc) -> X * Acc end, 1, SortedNegs);
                        1 -> lists:foldl(fun(X, Acc) -> X * Acc end, 1, tl(SortedNegs))
                    end;
                {Pos, Negs} ->
                    PosProduct = lists:foldl(fun(X, Acc) -> X * Acc end, 1, Pos),
                    SortedNegs = lists:sort(Negs),
                    case length(SortedNegs) rem 2 of
                        0 -> PosProduct * lists:foldl(fun(X, Acc) -> X * Acc end, 1, SortedNegs);
                        1 -> PosProduct * lists:foldl(fun(X, Acc) -> X * Acc end, 1, tl(SortedNegs))
                    end
            end
    end.