-spec generate_trees(N :: integer()) -> [[null | integer()]].
generate_trees(N) ->
    case N of
        0 -> [];
        _ -> generate(1, N)
    end.

generate(Start, End) ->
    if
        Start > End -> [null];
        true ->
            lists:foldl(fun(I, Acc) ->
                Lefts = generate(Start, I - 1),
                Rights = generate(I + 1, End),
                lists:foldl(fun(Left, AccLeft) ->
                    lists:foldl(fun(Right, AccRight) ->
                        [[I, Left, Right] | AccRight]
                    end, AccLeft, Rights)
                end, Acc, Lefts)
            end, [], lists:seq(Start, End))
    end.