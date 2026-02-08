-module(solution).
-export([daily_temperatures/1]).

daily_temperatures(TempsList) ->
    N = length(TempsList),
    TempsArray = array:from_list(TempsList),
    AnswerArray = array:new(N, {default, 0}),
    Stack = [],
    daily_temperatures_loop(0, N, TempsArray, AnswerArray, Stack).

daily_temperatures_loop(Index, N, TempsArray, AnswerArray, Stack) when Index < N ->
    CurrentTemp = array:get(Index, TempsArray),
    {UpdatedAnswerArray, NewStack} = pop_colder(CurrentTemp, Index, TempsArray, AnswerArray, Stack),
    daily_temperatures_loop(Index + 1, N, TempsArray, UpdatedAnswerArray, [Index | NewStack]);
daily_temperatures_loop(_Index, _N, _TempsArray, AnswerArray, _Stack) ->
    array:to_list(AnswerArray).

pop_colder(CurrentTemp, CurrentIndex, TempsArray, AnswerArray, Stack) ->
    case Stack of
        [] ->
            {AnswerArray, []};
        [PrevIndex | RestStack] ->
            PrevTemp = array:get(PrevIndex, TempsArray),
            if
                PrevTemp < CurrentTemp ->
                    UpdatedAnswerArray = array:set(PrevIndex, CurrentIndex - PrevIndex, AnswerArray),
                    pop_colder(CurrentTemp, CurrentIndex, TempsArray, UpdatedAnswerArray, RestStack);
                true ->
                    {AnswerArray, Stack}
            end
    end.