-spec majority_element(Counts :: [integer()]) -> integer().
majority_element(Counts) ->
    majority_element(Counts, 0, 0).

majority_element([], Candidate, _) ->
    Candidate;
majority_element([H | T], Candidate, Count) ->
    if
        Count =:= 0 ->
            majority_element(T, H, 1);
        H =:= Candidate ->
            majority_element(T, Candidate, Count + 1);
        true ->
            majority_element(T, Candidate, Count - 1)
    end.