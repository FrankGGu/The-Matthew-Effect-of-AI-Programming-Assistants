-spec reconstruct_queue(People :: [[integer()]]) -> [[integer()]].
reconstruct_queue(People) ->
    Sorted = lists:sort(fun([H1, K1], [H2, K2]) -> 
                            if H1 =:= H2 -> K1 =< K2;
                               true -> H1 > H2
                            end
                        end, People),
    reconstruct(Sorted, []).

reconstruct([], Acc) -> Acc;
reconstruct([[H, K] | Rest], Acc) ->
    {Left, Right} = lists:split(K, Acc),
    reconstruct(Rest, Left ++ [[H, K]] ++ Right).