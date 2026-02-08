-module(atm).
-export([init/1, deposit/1, withdraw/1]).

-record(state, {
    notes = [0, 0, 0, 0, 0] :: [integer()],
    values = [20, 50, 100, 200, 500] :: [integer()]
}).

init(_) ->
    #state{}.

deposit(State = #state{notes = Notes}, [Count20, Count50, Count100, Count200, Count500]) ->
    NewNotes = [
        lists:nth(1, Notes) + Count20,
        lists:nth(2, Notes) + Count50,
        lists:nth(3, Notes) + Count100,
        lists:nth(4, Notes) + Count200,
        lists:nth(5, Notes) + Count500
    ],
    {ok, State#state{notes = NewNotes}}.

withdraw(State = #state{notes = Notes, values = Values}, Amount) ->
    WithdrawResult = withdraw_notes(Notes, Values, Amount, []),
    case WithdrawResult of
        {ok, UsedNotes, RemainingNotes} ->
            {ok, UsedNotes, State#state{notes = RemainingNotes}};
        error ->
            {error, -1}
    end.

withdraw_notes(Notes, Values, 0, UsedNotes) ->
    {ok, lists:reverse(UsedNotes), Notes};
withdraw_notes([], _, _, _) ->
    error;
withdraw_notes([NoteCount | RestNotes], [Value | RestValues], Amount, UsedNotes) ->
    MaxUse = min(NoteCount, Amount div Value),
    try_note_use(MaxUse, NoteCount, Value, RestNotes, RestValues, Amount, UsedNotes).

try_note_use(0, _, _, RestNotes, RestValues, Amount, UsedNotes) ->
    withdraw_notes(RestNotes, RestValues, Amount, [0 | UsedNotes]);
try_note_use(Use, NoteCount, Value, RestNotes, RestValues, Amount, UsedNotes) ->
    NewAmount = Amount - Use * Value,
    if
        NewAmount >= 0 ->
            case withdraw_notes(RestNotes, RestValues, NewAmount, [Use | UsedNotes]) of
                {ok, FinalUsedNotes, FinalRemainingNotes} ->
                    NewRemainingNotes = [NoteCount - Use | lists:nthtail(1, FinalRemainingNotes)],
                    {ok, FinalUsedNotes, NewRemainingNotes};
                error ->
                    try_note_use(Use - 1, NoteCount, Value, RestNotes, RestValues, Amount, UsedNotes)
            end;
        true ->
            try_note_use(Use - 1, NoteCount, Value, RestNotes, RestValues, Amount, UsedNotes)
    end.