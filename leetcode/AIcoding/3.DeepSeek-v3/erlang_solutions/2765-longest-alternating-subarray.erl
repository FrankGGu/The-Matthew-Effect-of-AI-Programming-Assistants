-spec longest_alternating_subarray(Nums :: [integer()]) -> integer().
longest_alternating_subarray(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 1;
        _ ->
            MaxLen = 1,
            CurrentLen = 1,
            {FinalMax, _} = lists:foldl(fun(N, {Max, Curr, Prev}) ->
                case (Prev rem 2) =/= (N rem 2) of
                    true -> 
                        NewCurr = Curr + 1,
                        {max(Max, NewCurr), NewCurr, N};
                    false -> 
                        {max(Max, 1), 1, N}
                end
            end, {MaxLen, CurrentLen, hd(Nums)}, tl(Nums)),
            FinalMax
    end.