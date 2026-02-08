-spec longest_non_decreasing_subarray(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
longest_non_decreasing_subarray(Nums1, Nums2) ->
    {Len1, Len2, Max} = lists:foldl(fun(N, {Prev1, Prev2, PrevMax}) ->
        {Current1, Current2} = case N of
            1 -> 
                {if Prev1 =:= -1 -> 1; true -> Prev1 + 1 end, 
                 if Prev2 =:= -1 -> 1; true -> Prev2 + 1 end};
            2 -> 
                {if Prev2 =:= -1 -> 1; true -> Prev2 + 1 end, 
                 if Prev1 =:= -1 -> 1; true -> Prev1 + 1 end}
        end,
        {Current1, Current2, max(PrevMax, max(Current1, Current2))}
    end, {1, 1, 1}, lists:zipwith(fun(X, Y) -> if X =< Y -> 1; true -> 2 end end, Nums1, Nums2)),
    Max.