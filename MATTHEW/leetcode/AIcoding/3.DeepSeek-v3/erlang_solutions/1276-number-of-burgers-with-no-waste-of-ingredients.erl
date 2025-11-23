-spec num_of_burgers(TomatoSlices :: integer(), CheeseSlices :: integer()) -> [integer()].
num_of_burgers(TomatoSlices, CheeseSlices) ->
    case (TomatoSlices - 2 * CheeseSlices) of
        J when J >= 0, J rem 2 =:= 0 ->
            Jumbo = J div 2,
            Small = CheeseSlices - Jumbo,
            if
                Small >= 0 -> [Jumbo, Small];
                true -> []
            end;
        _ -> []
    end.