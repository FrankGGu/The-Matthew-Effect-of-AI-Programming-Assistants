-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    case Prices of
        [] -> 0;
        [P0 | RestPrices] ->
            InitialHold = -P0,
            InitialSold = -1000000000,
            InitialRest = 0,

            {_FinalHold, FinalSold, FinalRest} = lists:foldl(
                fun(Price, {PrevHold, PrevSold, PrevRest}) ->
                    NewHold = erlang:max(PrevHold, PrevRest - Price),
                    NewSold = PrevHold + Price,
                    NewRest = erlang:max(PrevRest, PrevSold),
                    {NewHold, NewSold, NewRest}
                end,
                {InitialHold, InitialSold, InitialRest},
                RestPrices
            ),
            erlang:max(FinalSold, FinalRest)
    end.