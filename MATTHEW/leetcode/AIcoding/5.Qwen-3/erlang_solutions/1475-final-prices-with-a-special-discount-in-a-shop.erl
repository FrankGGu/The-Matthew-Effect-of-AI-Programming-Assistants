-module(solution).
-export([final_prices/1]).

final_prices(Prices) ->
    final_prices(Prices, []).

final_prices([], Acc) ->
    lists:reverse(Acc);
final_prices([H | T], Acc) ->
    Discount = find_discount(T, H),
    final_prices(T, [H - Discount | Acc]).

find_discount([], _) ->
    0;
find_discount([H | T], Target) ->
    if
        H =< Target ->
            H;
        true ->
            find_discount(T, Target)
    end.