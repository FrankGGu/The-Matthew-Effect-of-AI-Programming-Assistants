-module(solution).
-export([get_number_of_backlog_orders/2]).

get_number_of_backlog_orders(Order, Max) ->
    Orders = lists:map(fun({Price, Amount, Type}) -> {Price, Amount, Type} end, Order),
    Orders1 = lists:foldl(fun({Price, Amount, Type}, Acc) ->
        case Type of
            0 -> 
                put_order(Acc, Price, Amount);
            1 -> 
                fulfill_order(Acc, Price, Amount)
        end
    end, [], Orders),
    lists:foldl(fun({_, Amount, _}, Acc) -> Acc + Amount end, 0, Orders1) rem (10^9 + 7).

put_order([], Price, Amount) -> [{Price, Amount}];
put_order([{P, A} | Rest], Price, Amount) when Price < P -> 
    [{Price, Amount} | [{P, A} | Rest]];
put_order([{P, A} | Rest], Price, Amount) when Price =:= P -> 
    [{P, A + Amount} | Rest];
put_order([{P, A} | Rest], Price, Amount) -> 
    [{P, A} | put_order(Rest, Price, Amount)].

fulfill_order(Orders, Price, Amount) ->
    case fulfill(Orders, Price, Amount) of
        {NewOrders, _} -> NewOrders;
        _ -> Orders
    end.

fulfill([], _, _) -> {[], 0};
fulfill([{P, A} | Rest], Price, Amount) when P <= Price ->
    case A >= Amount of
        true -> {Rest, A - Amount};
        false -> 
            {NewRest, NewAmount} = fulfill(Rest, Price, Amount - A),
            {[{P, NewAmount} | NewRest], 0}
    end;
fulfill([{P, A} | Rest], Price, Amount) ->
    {[{P, A} | Rest], Amount}.