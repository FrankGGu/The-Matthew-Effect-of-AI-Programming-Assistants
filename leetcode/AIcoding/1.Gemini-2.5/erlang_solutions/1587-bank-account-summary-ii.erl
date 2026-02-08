-module(solution).
-export([bank_account_summary_ii/2]).

bank_account_summary_ii(Users, Transactions) ->
    AccountBalances = lists:foldl(
        fun({_TransId, Account, Amount, _TransDate}, Acc) ->
            maps:update_with(Account, fun(Current) -> Current + Amount end, Amount, Acc)
        end,
        #{},
        Transactions
    ),

    FilteredUsersWithBalances = lists:foldl(
        fun({Account, Name}, Acc) ->
            case maps:find(Account, AccountBalances) of
                {ok, Balance} when Balance >= 10000 ->
                    [{Name, Balance} | Acc];
                _ ->
                    Acc
            end
        end,
        [],
        Users
    ),

    lists:sort(fun({NameA, _}, {NameB, _}) -> NameA =< NameB end, FilteredUsersWithBalances).