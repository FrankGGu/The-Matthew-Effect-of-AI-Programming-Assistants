-module(atm).
-export([withdraw/1]).

withdraw(Balance) ->
    case Balance of
        0 -> {0, []};
        _ -> withdraw(Balance, [500, 200, 100, 50, 20, 10, 5, 2, 1], [])
    end.

withdraw(_, [], Result) ->
    {0, lists:reverse(Result)};
withdraw(Balance, [Denom | Rest], Result) ->
    Count = Balance div Denom,
    NewBalance = Balance - (Count * Denom),
    if
        Count > 0 ->
            withdraw(NewBalance, Rest, [Count | Result]);
        true ->
            withdraw(Balance, Rest, Result)
    end.