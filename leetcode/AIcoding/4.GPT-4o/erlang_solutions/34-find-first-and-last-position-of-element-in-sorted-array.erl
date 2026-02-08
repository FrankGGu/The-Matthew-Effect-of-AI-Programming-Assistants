-spec search_range(Nums :: [integer()], Target :: integer()) -> [integer()].
search_range(Nums, Target) ->
    search_first(Nums, Target, 0, length(Nums) - 1).

search_first([], _, _, _) -> [-1, -1];
search_first([H | _], Target, L, R) when H == Target -> {L, L};
search_first([_ | T], Target, L, R) when L =< R ->
    search_first(T, Target, L + 1, R);
search_first(_, _, _, _) -> [-1, -1].
