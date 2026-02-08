-module(solution).
-export([num_ways_to_buy_pens_pencils/3]).

num_ways_to_buy_pens_pencils(TotalMoney, Cost1, Cost2) ->
    num_ways_to_buy_pens_pencils_recursive(TotalMoney, Cost1, Cost2, 0, 0).

num_ways_to_buy_pens_pencils_recursive(TotalMoney, Cost1, Cost2, N1, AccWays) ->
    CostOfPens = N1 * Cost1,
    if
        CostOfPens > TotalMoney ->
            AccWays;
        true ->
            RemainingMoney = TotalMoney - CostOfPens,
            NumPencilsPossible = RemainingMoney div Cost2,
            NewAccWays = AccWays + NumPencilsPossible + 1,
            num_ways_to_buy_pens_pencils_recursive(TotalMoney, Cost1, Cost2, N1 + 1, NewAccWays)
    end.