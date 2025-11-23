-module(atm).
-export([new/0, deposit/2, withdraw/2]).

new() ->
    [0, 0, 0, 0, 0].

deposit(State, Banknotes) ->
    lists:zipwith(fun(S, D) -> S + D end, State, Banknotes).

withdraw(State, Amount) ->
    Denominations = [500, 200, 100, 50, 20],
    CurrentCountsReversed = lists:reverse(State),

    case withdraw_helper(Amount, Denominations, CurrentCountsReversed, []) of
        {ok, DispensedCountsReversed} ->
            NewCountsReversed = lists:zipwith(fun(S, D) -> S - D end, CurrentCountsReversed, DispensedCountsReversed),
            NewState = lists:reverse(NewCountsReversed),
            {ok, NewState};
        {error, _} ->
            {error, State}
    end.

withdraw_helper(RemainingAmount, [], [], AccDispensed) ->
    case RemainingAmount of
        0 -> {ok, lists:reverse(AccDispensed)};
        _ -> {error, []}
    end;
withdraw_helper(RemainingAmount, [Denom | RestDenoms], [Count | RestCounts], AccDispensed) ->
    NumToDispense = min(RemainingAmount div Denom, Count),
    NewRemainingAmount = RemainingAmount - NumToDispense * Denom,
    withdraw_helper(NewRemainingAmount, RestDenoms, RestCounts, [NumToDispense | AccDispensed]).