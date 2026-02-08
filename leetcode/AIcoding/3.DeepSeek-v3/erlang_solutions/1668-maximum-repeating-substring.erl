-spec max_repeating(Sequence :: unicode:unicode_binary(), Word :: unicode:unicode_binary()) -> integer().
max_repeating(Sequence, Word) ->
    S = binary_to_list(Sequence),
    W = binary_to_list(Word),
    LenS = length(S),
    LenW = length(W),
    MaxK = LenS div LenW,
    find_max_k(S, W, MaxK, 0).

find_max_k(_, _, 0, Max) -> Max;
find_max_k(S, W, K, Max) ->
    Repeated = lists:flatten(lists:duplicate(K, W)),
    case string:str(S, Repeated) of
        0 -> find_max_k(S, W, K - 1, Max);
        _ -> K
    end.