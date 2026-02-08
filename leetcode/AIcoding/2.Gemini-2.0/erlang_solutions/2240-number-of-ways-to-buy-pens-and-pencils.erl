-module(solution).
-export([ways_to_buy_pens_pencils/4]).

ways_to_buy_pens_pencils(Total, Cost1, Count1, Cost2, Count2) ->
  NumWays = 0,
  MaxPens = Total div Cost1,

  lists:foldl(fun(Pens, Acc) ->
                  Remaining = Total - (Pens * Cost1),
                  Pencils = Remaining div Cost2,
                  Acc + Pencils + 1
              end, 0, lists:seq(0, min(MaxPens, Count1))).