-spec can_divide_into_subsequences(Nums :: [integer()], K :: integer()) -> boolean().
can_divide_into_subsequences(Nums, K) ->
    case length(Nums) rem K of
        0 ->
            Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
            Sorted = lists:sort(maps:keys(Freq)),
            can_form_sequences(Sorted, Freq, K);
        _ ->
            false
    end.

can_form_sequences([], _, _) -> true;
can_form_sequences([H | T], Freq, K) ->
    case maps:get(H, Freq, 0) of
        0 ->
            can_form_sequences(T, Freq, K);
        Count ->
            case check_consecutive(H, K, Freq, Count) of
                true ->
                    NewFreq = decrement_counts(H, K, Freq, Count),
                    can_form_sequences(T, NewFreq, K);
                false ->
                    false
            end
    end.

check_consecutive(Start, K, Freq, Count) ->
    lists:all(fun(I) -> maps:get(Start + I, Freq, 0) >= Count end, lists:seq(0, K - 1)).

decrement_counts(Start, K, Freq, Count) ->
    lists:foldl(fun(I, Acc) -> maps:update_with(Start + I, fun(V) -> V - Count end, Acc) end, Freq, lists:seq(0, K - 1)).