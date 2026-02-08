-module(solution).
-export([invalid_transactions/1]).

invalid_transactions(Transactions) ->
    Parsed = lists:map(fun parse_transaction/1, Transactions),
    lists:foldl(fun({Name, Time, Amount, City, Original}, Acc) ->
        case Amount > 1000 orelse is_invalid(Parsed, Name, Time, City, Original) of
            true -> [Original | Acc];
            false -> Acc
        end
    end, [], Parsed).

parse_transaction(Transaction) ->
    [Name, TimeStr, AmountStr, City] = string:tokens(Transaction, ","),
    {Time, _} = string:to_integer(TimeStr),
    {Amount, _} = string:to_integer(AmountStr),
    {Name, Time, Amount, City, Transaction}.

is_invalid(Transactions, Name, Time, City, Original) ->
    lists:any(fun({N, T, _, C, _}) ->
        N =:= Name andalso C =/= City andalso abs(T - Time) =< 60
    end, Transactions).