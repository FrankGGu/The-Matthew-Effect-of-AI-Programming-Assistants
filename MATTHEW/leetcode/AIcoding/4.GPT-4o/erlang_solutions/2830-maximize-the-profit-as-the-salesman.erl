-module(solution).
-export([maximize_profit/2]).

maximize_profit(Prices, Fee) ->
    maximize_profit_helper(Prices, Fee, 0, 0).

maximize_profit_helper([], _, Cash, _) -> 
    Cash;
maximize_profit_helper([Price | Rest], Fee, Cash, Hold) ->
    Hold =:= 0 
    -> maximize_profit_helper(Rest, Fee, Cash, Price)
    ; maximize_profit_helper(Rest, Fee, max(Cash, Hold + Price - Fee), max(Hold, Price)).