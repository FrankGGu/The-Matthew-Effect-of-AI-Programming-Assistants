-spec majority_element(Nums :: [integer()]) -> [integer()].
majority_element(Nums) ->
    Boyer_Moore_Voting(Nums, [], 0, 0).

-spec Boyer_Moore_Voting([integer()], [integer()], integer(), integer()) -> [integer()].
Boyer_Moore_Voting([], Cands, _, _) -> Cands;
Boyer_Moore_Voting([H | T], [], C1, C2) ->
    Boyer_Moore_Voting(T, [H], 1, 0);
Boyer_Moore_Voting([H | T], [Cand | Rest], C1, C2) when Cand =:= H ->
    Boyer_Moore_Voting(T, [Cand], C1 + 1, C2);
Boyer_Moore_Voting([H | T], [Cand | Rest], C1, C2) when C1 =< C2 ->
    Boyer_Moore_Voting(T, [H | Rest], C1 + 1, C2);
Boyer_Moore_Voting([H | T], [Cand | Rest], C1, C2) ->
    Boyer_Moore_Voting(T, Rest, C1 - 1, C2 + 1).
