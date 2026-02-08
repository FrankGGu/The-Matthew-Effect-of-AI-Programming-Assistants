-module(solution).
-export([final_prices/1]).

final_prices(Prices) ->
    final_prices(Prices, []).

final_prices([], Acc) ->
    lists:reverse(Acc);
final_prices([H | T], Acc) ->
    FinalPrice = calculate_price(H, T, 0),
    final_prices(T, [FinalPrice | Acc]).

calculate_price(Price, [], _) ->
    Price;
calculate_price(Price, [H | T], Discount) ->
    case H >= Price of
        true -> Price - Discount;
        false -> calculate_price(Price, T, H)
    end.