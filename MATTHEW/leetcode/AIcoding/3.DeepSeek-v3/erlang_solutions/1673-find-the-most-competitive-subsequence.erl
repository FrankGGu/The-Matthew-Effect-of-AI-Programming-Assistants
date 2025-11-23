-spec most_competitive(Nums :: [integer()], K :: integer()) -> [integer()].
most_competitive(Nums, K) ->
    Stack = [],
    Len = length(Nums),
    most_competitive(Nums, Stack, Len, K).

most_competitive([], Stack, _, K) ->
    lists:reverse(Stack);
most_competitive([H | T], Stack, Len, K) ->
    case Stack of
        [] ->
            most_competitive(T, [H | Stack], Len - 1, K - 1);
        [Top | Rest] ->
            case (length(Stack) + Len - 1 >= K) andalso (Top > H) of
                true ->
                    most_competitive([H | T], Rest, Len, K);
                false ->
                    case length(Stack) < K of
                        true ->
                            most_competitive(T, [H | Stack], Len - 1, K);
                        false ->
                            most_competitive(T, Stack, Len - 1, K)
                    end
            end
    end.