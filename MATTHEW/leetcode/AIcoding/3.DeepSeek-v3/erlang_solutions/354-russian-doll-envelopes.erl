-spec max_envelopes(Envelopes :: [[integer()]]) -> integer().
max_envelopes(Envelopes) ->
    Sorted = lists:sort(fun([W1, H1], [W2, H2]) ->
                            if W1 =:= W2 -> H1 > H2;
                               true -> W1 < W2
                            end
                        end, Envelopes),
    Heights = [H || [_, H] <- Sorted],
    dp(Heights, []).

dp([], DP) -> length(DP);
dp([H | T], DP) ->
    case find_first_larger(DP, H) of
        not_found ->
            dp(T, DP ++ [H]);
        Index ->
            NewDP = lists:sublist(DP, Index - 1) ++ [H] ++ lists:nthtail(Index, DP),
            dp(T, NewDP)
    end.

find_first_larger(List, Target) ->
    find_first_larger(List, Target, 1, length(List)).

find_first_larger([], _, _, _) -> not_found;
find_first_larger([H | _], Target, Index, _) when H >= Target -> Index;
find_first_larger([_ | T], Target, Index, Len) ->
    find_first_larger(T, Target, Index + 1, Len).