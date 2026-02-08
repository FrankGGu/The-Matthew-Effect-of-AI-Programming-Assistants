-spec search(Nums :: [integer()], Target :: integer()) -> integer().
search(Nums, Target) ->
    search(Nums, Target, 0, length(Nums) - 1).

search(_, _, Low, High) when Low > High -> -1;
search(Nums, Target, Low, High) ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid, Nums) of
        Target -> Mid;
        Value when Value < lists:nth(Low, Nums) ->
            if Target < Value -> search(Nums, Target, Mid + 1, High);
            true -> search(Nums, Target, Low, Mid - 1)
            end;
        _ -> search(Nums, Target, Low, Mid - 1)
    end.
