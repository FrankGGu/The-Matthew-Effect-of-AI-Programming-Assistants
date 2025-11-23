-spec visible_people(Heights :: [integer()]) -> [integer()].
visible_people(Heights) ->
    Stack = [],
    Result = lists:duplicate(length(Heights), 0),
    {_, FinalResult} = lists:foldl(fun process/2, {Stack, Result}, lists:zip(lists:seq(1, length(Heights)), Heights)),
    FinalResult.

process({Index, Height}, {Stack, Result}) ->
    {NewStack, Count} = pop_stack(Stack, Height, 0),
    NewResult = case NewStack of
        [] -> Result;
        _ -> setelement(Index, Result, getelement(Index, Result) + 1)
    end,
    {[{Height, Index} | NewStack], NewResult}.

pop_stack([], _, Count) -> {[], Count};
pop_stack([{H, I} | Rest], Height, Count) when H < Height ->
    {NewRest, NewCount} = pop_stack(Rest, Height, Count + 1),
    {NewRest, NewCount + 1};
pop_stack(Stack, _, Count) -> {Stack, Count}.

getelement(1, Tuple) -> element(1, Tuple);
getelement(N, Tuple) -> element(N, Tuple).

setelement(1, Tuple, Value) -> erlang:setelement(1, Tuple, Value);
setelement(N, Tuple, Value) -> erlang:setelement(N, Tuple, Value).