-module(solution).
-export([odd_and_even_transactions/1]).

odd_and_even_transactions(Transactions) ->
    lists:reverse(lists:keysort(1, 
        lists:foldl(fun(Trans, Acc) ->
            [Id, _, Amount, _] = Trans,
            case Amount rem 2 of
                1 -> [{Id, 1} | Acc];
                0 -> [{Id, 0} | Acc]
            end
        end, [], Transactions))).