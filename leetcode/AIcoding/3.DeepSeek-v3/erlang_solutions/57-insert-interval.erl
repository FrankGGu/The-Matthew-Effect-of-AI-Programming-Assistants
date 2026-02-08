-spec insert(Intervals :: [[integer()]], NewInterval :: [integer()]) -> [[integer()]].
insert(Intervals, NewInterval) ->
    {Start, End} = case NewInterval of
        [S, E] -> {S, E};
        _ -> {0, 0}
    end,
    Left = lists:takewhile(fun([S, _]) -> S < Start end, Intervals),
    Right = lists:dropwhile(fun([_, E]) -> E < Start end, Intervals),
    case Right of
        [] ->
            Left ++ [NewInterval];
        [[S1, E1] | Rest] ->
            if
                End < S1 ->
                    Left ++ [NewInterval] ++ Right;
                true ->
                    NewStart = min(Start, S1),
                    NewEnd = max(End, E1),
                    Left ++ [[NewStart, NewEnd]] ++ lists:dropwhile(fun([S, _]) -> S =< NewEnd end, Rest)
            end
    end.

min(A, B) when A =< B -> A;
min(_, B) -> B.

max(A, B) when A >= B -> A;
max(_, B) -> B.