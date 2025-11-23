-module(solution).
-export([cashier/2]).

cashier(Customers, N) ->
    cashier(Customers, N, 1, 0, []).

cashier([], _, _, _, Acc) ->
    lists:reverse(Acc);
cashier([Customer | Rest], N, Count, Total, Acc) ->
    case Count rem N of
        0 ->
            NewTotal = Total + Customer * 0.9,
            cashier(Rest, N, Count + 1, NewTotal, [NewTotal | Acc]);
        _ ->
            NewTotal = Total + Customer,
            cashier(Rest, N, Count + 1, NewTotal, [NewTotal | Acc])
    end.