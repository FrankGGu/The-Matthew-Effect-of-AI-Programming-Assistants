-spec max_envelopes(Envelopes :: [[integer()]]) -> integer().
max_envelopes(Envelopes) ->
    EnvelopesSorted = lists:sort(fun({W1, H1}, {W2, H2}) -> W1 =:= W2 andalso H1 < H2; W1 < W2 -> true; true -> false end, Envelopes),
    max_envelopes_sorted(EnvelopesSorted).

-spec max_envelopes_sorted(Envelopes :: [[integer()]]) -> integer().
max_envelopes_sorted(Envelopes) ->
    Heights = lists:map(fun({_, H}) -> H end, Envelopes),
    longest_increasing_subsequence(Heights).

-spec longest_increasing_subsequence(Seq :: [integer()]) -> integer().
longest_increasing_subsequence(Seq) ->
    lists:foldl(fun(E, Acc) -> 
                    case lists:keyfind(E, 1, Acc) of
                        false -> [E | Acc];
                        _ -> Acc
                    end
                end, [], Seq).
