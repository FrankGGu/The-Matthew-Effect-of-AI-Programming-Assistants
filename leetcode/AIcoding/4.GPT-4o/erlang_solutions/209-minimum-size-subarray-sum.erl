-spec min_sub_array_len(Target :: integer(), Nums :: [integer()]) -> integer().
min_sub_array_len(Target, Nums) ->
    min_sub_array_len(Target, Nums, 0, 0, length(Nums) + 1).

min_sub_array_len(_, [], _, _, Result) -> 
    case Result =< length(Nums) of
        true -> Result;
        false -> 0
    end;
min_sub_array_len(Target, [Head | Tail], Start, Sum, Result) ->
    NewSum = Sum + Head,
    NewResult = case NewSum >= Target of
                    true -> min(Result, length(Tail) + Start + 1);
                    false -> Result
                end,
    min_sub_array_len(Target, Tail, Start + 1, NewSum, NewResult).
