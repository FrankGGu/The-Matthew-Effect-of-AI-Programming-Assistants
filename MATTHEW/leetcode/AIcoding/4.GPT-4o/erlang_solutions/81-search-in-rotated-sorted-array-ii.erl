-spec search(Nums :: [integer()], Target :: integer()) -> boolean().
search(Nums, Target) ->
    search(Nums, Target, 0, length(Nums) - 1).

search(_, _, Low, High) when Low > High -> false;
search(Nums, Target, Low, High) ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid + 1, Nums) of
        Val when Val =:= Target -> true;
        Val when Val > Target -> search(Nums, Target, Low, Mid - 1);
        Val -> search(Nums, Target, Mid + 1, High)
    end.
