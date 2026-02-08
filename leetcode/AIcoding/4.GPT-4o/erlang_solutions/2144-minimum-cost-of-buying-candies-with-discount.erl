-module(solution).
-export([candyCost/1]).

candyCost(Candies) ->
    TotalCost = lists:foldl(fun({Cost, _}, Acc) -> Acc + Cost end, 0, Candies),
    DiscountedCost = lists:foldl(fun({Cost, Count}, Acc) -> 
                                      Acc + if 
                                              Count rem 2 =:= 0 -> Cost div 2;
                                              true -> Cost
                                          end 
                                  end, 0, Candies),
    TotalCost - DiscountedCost.