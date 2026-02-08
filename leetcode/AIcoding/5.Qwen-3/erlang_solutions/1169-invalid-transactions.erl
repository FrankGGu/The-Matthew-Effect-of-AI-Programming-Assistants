-module(invalid_transactions).
-export([invalidTransactions/1]).

invalidTransactions(Transactions) ->
    lists:filter(fun(T) -> is_invalid(T, Transactions) end, Transactions).

is_invalid(Transaction, AllTransactions) ->
    [Name, Time, Amount, City] = string:split(Transaction, ","),
    AmountInt = list_to_integer(Amount),
    if
        AmountInt >= 1000 ->
            true;
        true ->
            lists:any(fun(T) ->
                [TName, TTime, TAmount, TCity] = string:split(T, ","),
                TAmountInt = list_to_integer(TAmount),
                TTimeInt = list_to_integer(TTime),
                TName == Name,
                abs(list_to_integer(Time) - TTimeInt) <= 60,
                TCity /= City
            end, AllTransactions)
    end.