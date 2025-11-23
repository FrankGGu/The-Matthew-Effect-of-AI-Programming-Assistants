-spec interval_intersection(FirstList :: [[integer()]], SecondList :: [[integer()]]) -> [[integer()]].
interval_intersection(FirstList, SecondList) ->
    interval_intersection(FirstList, SecondList, []).

interval_intersection([], _, Acc) ->
    lists:reverse(Acc);
interval_intersection(_, [], Acc) ->
    lists:reverse(Acc);
interval_intersection([A | As] = AList, [B | Bs] = BList, Acc) ->
    [AStart, AEnd] = A,
    [BStart, BEnd] = B,
    case {AEnd < BStart, BEnd < AStart} of
        {true, _} ->
            interval_intersection(As, BList, Acc);
        {_, true} ->
            interval_intersection(AList, Bs, Acc);
        _ ->
            Start = max(AStart, BStart),
            End = min(AEnd, BEnd),
            NewAcc = [[Start, End] | Acc],
            if
                AEnd < BEnd -> interval_intersection(As, BList, NewAcc);
                true -> interval_intersection(AList, Bs, NewAcc)
            end
    end.

max(A, B) when A > B -> A;
max(_, B) -> B.

min(A, B) when A < B -> A;
min(_, B) -> B.