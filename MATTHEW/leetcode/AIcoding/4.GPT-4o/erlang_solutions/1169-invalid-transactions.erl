-module(solution).
-export([invalidTransactions/1]).

invalidTransactions(Transactions) ->
    lists:filter(fun(Trans) -> is_invalid(Trans, Transactions) end, Transactions).

is_invalid(Transaction, Transactions) ->
    [Name, Time, AmountStr, City] = string:split(Transaction, ","),
    Amount = list_to_integer(AmountStr),
    Time = list_to_integer(Time),
    (Amount > 1000 orelse has_invalid_time(Name, Time, Transactions)).

has_invalid_time(Name, Time, Transactions) ->
    lists:any(fun(Trans) ->
        [TransName, TransTimeStr, _, TransCity] = string:split(Trans, ","),
        TransTime = list_to_integer(TransTimeStr),
        TransCity = lists:nth(3, string:split(Trans, ",")),
        Name =/= TransName andalso
        abs(Time - TransTime) <= 60 andalso
        City /= TransCity
    end, Transactions).