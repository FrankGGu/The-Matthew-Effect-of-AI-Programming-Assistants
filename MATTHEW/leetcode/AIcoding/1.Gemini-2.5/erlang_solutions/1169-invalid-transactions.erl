-module(solution).
-export([invalidTransactions/1]).

-record(transaction, {name :: string(), time :: integer(), amount :: integer(), city :: string(), original :: string()}).

invalidTransactions(Transactions) ->
    ParsedTransactions = parse_transactions(Transactions),

    InitialInvalidSet = sets:new(),
    {AllTransactions, InvalidSetAfterAmountCheck} = lists:foldl(
        fun(Txn = #transaction{amount = Amount, original = Original}, {AccTxns, AccInvalidSet}) ->
            NewInvalidSet = if Amount > 1000 -> sets:add_element(Original, AccInvalidSet); true -> AccInvalidSet end,
            {[Txn | AccTxns], NewInvalidSet}
        end,
        {[], InitialInvalidSet},
        ParsedTransactions
    ),

    FinalInvalidSet = lists:foldl(
        fun(Txn1 = #transaction{name = Name1, time = Time1, city = City1, original = Original1}, AccInvalidSet) ->
            InvalidDueToOthers = lists:any(
                fun(Txn2 = #transaction{name = Name2, time = Time2, city = City2}) ->
                    Name1 == Name2 andalso City1 =/= City2 andalso abs(Time1 - Time2) =< 60
                end,
                AllTransactions
            ),
            if InvalidDueToOthers -> sets:add_element(Original1, AccInvalidSet); true -> AccInvalidSet end
        end,
        InvalidSetAfterAmountCheck,
        AllTransactions
    ),

    sets:to_list(FinalInvalidSet).

parse_transactions(Transactions) ->
    lists:map(fun(TxnStr) ->
        [NameStr, TimeStr, AmountStr, CityStr] = string:split(TxnStr, ",", all),
        #transaction{
            name = NameStr,
            time = list_to_integer(TimeStr),
            amount = list_to_integer(AmountStr),
            city = CityStr,
            original = TxnStr
        }
    end, Transactions).