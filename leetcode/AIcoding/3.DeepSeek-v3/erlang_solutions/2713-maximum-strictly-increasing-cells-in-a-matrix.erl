-spec max_increasing_cells(Matrix :: [[integer()]]) -> integer().
max_increasing_cells(Matrix) ->
    M = length(Matrix),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Matrix)),
            RowMax = maps:new(),
            ColMax = maps:new(),
            Sorted = lists:sort([{lists:nth(J, lists:nth(I, Matrix)), I-1, J-1} || I <- lists:seq(1, M), J <- lists:seq(1, N)]),
            DP = array:new([{size, M}, {default, array:new([{size, N}, {default, 1}])}]),
            {RowMax1, ColMax1, _} = lists:foldl(fun({Val, I, J}, {RM, CM, Dp}) ->
                Max = max(maps:get(Val, RM, #{}) |> maps:get(I, 0), maps:get(Val, CM, #{}) |> maps:get(J, 0)) + 1,
                Dp1 = array:set(I, array:set(J, Max, array:get(I, Dp)), Dp),
                RM1 = case maps:is_key(Val, RM) of
                    true -> 
                        case maps:is_key(I, maps:get(Val, RM)) of
                            true -> 
                                Current = maps:get(I, maps:get(Val, RM)),
                                maps:update(Val, maps:update(I, max(Current, Max), maps:get(Val, RM)), RM);
                            false -> 
                                maps:update(Val, maps:put(I, Max, maps:get(Val, RM)), RM)
                        end;
                    false -> 
                        maps:put(Val, #{I => Max}, RM)
                end,
                CM1 = case maps:is_key(Val, CM) of
                    true -> 
                        case maps:is_key(J, maps:get(Val, CM)) of
                            true -> 
                                Current = maps:get(J, maps:get(Val, CM)),
                                maps:update(Val, maps:update(J, max(Current, Max), maps:get(Val, CM)), CM);
                            false -> 
                                maps:update(Val, maps:put(J, Max, maps:get(Val, CM)), CM)
                        end;
                    false -> 
                        maps:put(Val, #{J => Max}, CM)
                end,
                {RM1, CM1, Dp1}
            end, {RowMax, ColMax, DP}, Sorted),
            lists:max([lists:max(array:to_list(array:get(I, DP))) || I <- lists:seq(0, M-1)])
    end.