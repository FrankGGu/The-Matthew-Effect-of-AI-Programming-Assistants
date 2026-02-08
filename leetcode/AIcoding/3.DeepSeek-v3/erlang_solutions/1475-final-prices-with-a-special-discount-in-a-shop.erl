-spec final_prices(Prices :: [integer()]) -> [integer()].
final_prices(Prices) ->
    final_prices(Prices, []).

final_prices([], Acc) ->
    lists:reverse(Acc);
final_prices([P | Rest], Acc) ->
    Discount = find_discount(P, Rest),
    final_prices(Rest, [P - Discount | Acc]).

find_discount(_, []) -> 0;
find_discount(P, [H | _]) when H =< P -> H;
find_discount(P, [_ | T]) -> find_discount(P, T).