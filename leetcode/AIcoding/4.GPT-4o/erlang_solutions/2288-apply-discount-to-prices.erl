-module(solution).
-export([apply_discount/2]).

apply_discount(Prices, Discount) ->
    lists:map(fun(Price) ->
        case string:to_integer(Price) of
            {error, _} -> Price;
            PriceInt ->
                NewPrice = PriceInt * (100 - Discount) div 100,
                integer_to_list(NewPrice)
        end
    end, Prices).