-module(atm_machine).
-export([new/0, deposit/3, withdraw/2, get_balance/0]).

-record(atm, {balance = 0, notes = #{5 => 0, 10 => 0, 20 => 0, 50 => 0, 100 => 0}}).

new() ->
    erlang:make_ref().

deposit(ATM, Amount, Notes) ->
    ATM#atm{balance = ATM#atm.balance + Amount,
             notes = maps:update(Notes, ATM#atm.notes, fun(X) -> X + 1 end)}.

withdraw(ATM, Amount) ->
    Notes = [100, 50, 20, 10, 5],
    {ATM, Amount} = withdraw_helper(ATM, Amount, Notes),
    {ATM, Amount}.

get_balance(ATM) ->
    ATM#atm.balance.

withdraw_helper(ATM, Amount, []) ->
    {ATM, Amount};
withdraw_helper(ATM, Amount, [Note | Rest]) ->
    NoteCount = maps:get(Note, ATM#atm.notes),
    Needed = Amount div Note,
    ToTake = min(NoteCount, Needed),
    NewATM = ATM#atm{notes = maps:update(Note, ATM#atm.notes, fun(X) -> X - ToTake end),
                      balance = ATM#atm.balance - ToTake * Note},
    withdraw_helper(NewATM, Amount - ToTake * Note, Rest).