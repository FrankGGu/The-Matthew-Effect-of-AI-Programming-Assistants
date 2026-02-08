-spec merge_triplets(Triplets :: [[integer()]], Target :: [integer()]) -> boolean().
merge_triplets(Triplets, Target) ->
    [A, B, C] = Target,
    Possible = lists:foldl(fun([X, Y, Z], Acc) ->
        case X =< A andalso Y =< B andalso Z =< C of
            true -> [{X, Y, Z} | Acc];
            false -> Acc
        end
    end, [], Triplets),
    {ResA, ResB, ResC} = lists:foldl(fun({X, Y, Z}, {AccA, AccB, AccC}) ->
        {max(X, AccA), max(Y, AccB), max(Z, AccC)}
    end, {0, 0, 0}, Possible),
    ResA == A andalso ResB == B andalso ResC == C.