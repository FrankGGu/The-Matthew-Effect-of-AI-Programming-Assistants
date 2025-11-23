-spec max_width_ramp(Nums :: [integer()]) -> integer().
max_width_ramp(Nums) ->
    Stack = [],
    {Stack1, _} = lists:foldl(fun(X, {S, I}) ->
        case S of
            [] -> {[{X, I} | S], I + 1};
            [{Y, _} | _] when X < Y -> {[{X, I} | S], I + 1};
            _ -> {S, I + 1}
        end
    end, {Stack, 0}, Nums),
    lists:foldl(fun({X, J}, {Max, I}) ->
        case Stack1 of
            [{Y, K} | Rest] when X >= Y ->
                NewMax = max(Max, J - K),
                NewStack = case Rest of
                    [{Z, _} | _] when X >= Z -> Stack1;
                    _ -> Rest
                end,
                {NewMax, I + 1};
            _ ->
                {Max, I + 1}
        end
    end, {0, length(Nums) - 1}, lists:reverse(Nums)),
    element(1, lists:foldl(fun(X, {Max, I}) ->
        case Stack1 of
            [{Y, J} | Rest] when X >= Y ->
                NewMax = max(Max, I - J),
                NewStack = case Rest of
                    [{Z, _} | _] when X >= Z -> Stack1;
                    _ -> Rest
                end,
                {NewMax, I + 1};
            _ ->
                {Max, I + 1}
        end
    end, {0, 0}, Nums)).