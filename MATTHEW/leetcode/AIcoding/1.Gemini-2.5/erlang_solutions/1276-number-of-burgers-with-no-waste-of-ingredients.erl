-module(solution).
-export([numOfBurgers/2]).

numOfBurgers(TomatoSlices, CheeseSlices) ->
    if
        TomatoSlices rem 2 == 0 andalso
        TomatoSlices >= 2 * CheeseSlices andalso
        TomatoSlices <= 4 * CheeseSlices ->
            Jumbo = (TomatoSlices - 2 * CheeseSlices) div 2,
            Small = CheeseSlices - Jumbo,
            [Jumbo, Small];
        true ->
            []
    end.