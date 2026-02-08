-spec find_min(Nums :: [integer()]) -> integer().
find_min(Nums) ->
    find_min(Nums, 1, length(Nums)).

find_min([H|_], Start, End) when Start >= End ->
    H;
find_min(Nums, Start, End) ->
    Mid = Start + (End - Start) div 2,
    case lists:nth(Mid, Nums) > lists:nth(End, Nums) of
        true -> find_min(Nums, Mid + 1, End);
        false -> find_min(Nums, Start, Mid)
    end.