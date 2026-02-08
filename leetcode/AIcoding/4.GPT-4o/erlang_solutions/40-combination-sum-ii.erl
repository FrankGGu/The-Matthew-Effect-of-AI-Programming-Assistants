-spec combination_sum2(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum2(Candidates, Target) ->
    combination_sum2(Candidates, Target, []).

combination_sum2([], _, Acc) -> [lists:reverse(Acc)];
combination_sum2([Head | Tail], Target, Acc) when Head > Target -> combination_sum2(Tail, Target, Acc);
combination_sum2([Head | Tail], Target, Acc) ->
    combination_sum2(Tail, Target, Acc) ++ combination_sum2(Tail, Target - Head, [Head | Acc]).
