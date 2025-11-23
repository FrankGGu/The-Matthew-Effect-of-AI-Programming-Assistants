-spec crack_safe(N :: integer(), K :: integer()) -> unicode:unicode_binary().
crack_safe(N, K) ->
    case N of
        1 ->
            list_to_binary([$0 + X || X <- lists:seq(0, K-1)]);
        _ ->
            Total = trunc(math:pow(K, N)),
            Visited = sets:new(),
            Start = lists:duplicate(N, $0),
            {Result, _} = dfs(Start, Total, Visited, K),
            list_to_binary(Result)
    end.

dfs(Current, Total, Visited, K) ->
    case sets:size(Visited) of
        Total ->
            {Current, Visited};
        _ ->
            Prefix = lists:sublist(Current, 2, length(Current) - 1),
            lists:foldl(
                fun(X, {AccStr, AccVisited}) ->
                    Next = Prefix ++ [X + $0],
                    case sets:is_element(Next, AccVisited) of
                        false ->
                            NewVisited = sets:add_element(Next, AccVisited),
                            {NewStr, NewVisited2} = dfs(Next, Total, NewVisited, K),
                            case NewStr of
                                [] -> {AccStr, AccVisited};
                                _ -> {AccStr ++ [X + $0], NewVisited2}
                            end;
                        true ->
                            {AccStr, AccVisited}
                    end
                end,
                {[], Visited},
                lists:seq(0, K-1)
            )
    end.