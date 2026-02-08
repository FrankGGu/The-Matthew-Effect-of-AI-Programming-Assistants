-spec maximum_jumps(Nums :: [integer()], Target :: integer()) -> integer().
maximum_jumps(Nums, Target) ->
    N = length(Nums),
    DP = array:new([{size, N}, {default, -1}]),
    DP1 = array:set(N - 1, 0, DP),
    MaxJumps = solve(0, Nums, Target, DP1),
    case MaxJumps of
        -1 -> -1;
        _ -> MaxJumps
    end.

solve(I, Nums, Target, DP) ->
    case array:get(I, DP) of
        -1 ->
            Max = -1,
            N = length(Nums),
            lists:foldl(fun(J, CurrentMax) ->
                if
                    J > I, J < N, abs(lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums)) =< Target ->
                        Next = solve(J, Nums, Target, DP),
                        if
                            Next =/= -1, (CurrentMax =:= -1 orelse Next + 1 > CurrentMax) ->
                                Next + 1;
                            true ->
                                CurrentMax
                        end;
                    true ->
                        CurrentMax
                end
            end, Max, lists:seq(I + 1, N - 1)),
            array:set(I, Max, DP),
            Max;
        Val ->
            Val
    end.