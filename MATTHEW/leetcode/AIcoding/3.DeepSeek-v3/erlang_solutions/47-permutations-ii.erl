-spec permute_unique(Nums :: [integer()]) -> [[integer()]].
permute_unique(Nums) ->
    permute_unique(lists:sort(Nums), [], []).

permute_unique([], _, Acc) ->
    Acc;
permute_unique([H|T], Used, Acc) ->
    case lists:member(H, Used) of
        true -> permute_unique(T, Used, Acc);
        false -> 
            NewAcc = permute_unique(T, [H|Used], Acc),
            permute_unique(T, Used, permute_helper(H, T, NewAcc))
    end.

permute_helper(X, Rest, Acc) ->
    case Acc of
        [] -> [[X|Rest]];
        _ -> [[X|L] || L <- Acc]
    end.