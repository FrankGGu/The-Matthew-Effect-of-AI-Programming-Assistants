-spec search(Nums :: [integer()], Target :: integer()) -> integer().
search(Nums, Target) ->
    BinSearch = fun BinSearch(L, R) ->
        if
            L > R -> -1;
            true ->
                Mid = L + (R - L) div 2,
                case lists:nth(Mid + 1, Nums) of
                    Target -> Mid;
                    Num when Num < Target -> BinSearch(Mid + 1, R);
                    _ -> BinSearch(L, Mid - 1)
                end
        end
    end,
    BinSearch(0, length(Nums) - 1).