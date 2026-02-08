-spec combination_sum(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum(Candidates, Target) ->
    combination_sum(Candidates, Target, [], []).

combination_sum([], _, _, Acc) -> lists:reverse(Acc);
combination_sum([Head | Tail], Target, Current, Acc) when Head =< Target ->
    combination_sum([Head | Tail], Target - Head, [Head | Current], Acc);
combination_sum([_ | Tail], Target, Current, Acc) ->
    combination_sum(Tail, Target, Current, Acc);
combination_sum([_ | Tail], Target, [], Acc) ->
    combination_sum(Tail, Target, [], Acc);
combination_sum([_ | Tail], Target, Current, Acc) ->
    combination_sum(Tail, Target, [], [[Current | Acc] | Acc]).
