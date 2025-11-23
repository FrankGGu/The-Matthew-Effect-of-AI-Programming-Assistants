-spec circular_array_loop(Nums :: [integer()]) -> boolean().
circular_array_loop(Nums) ->
    N = length(Nums),
    Visited = array:new([{size, N}, {default, false}]),
    lists:any(fun(I) -> check_loop(I, Nums, N, Visited) end, lists:seq(0, N - 1)).

check_loop(Start, Nums, N, Visited) ->
    case array:get(Start, Visited) of
        true -> false;
        false ->
            Visited1 = array:set(Start, true, Visited),
            Direction = case lists:nth(Start + 1, Nums) > 0 of true -> 1; false -> -1 end,
            Next = (Start + lists:nth(Start + 1, Nums)) rem N,
            Next1 = if Next < 0 -> Next + N; true -> Next end,
            if
                Next1 =:= Start -> false;
                Direction =/= (case lists:nth(Next1 + 1, Nums) > 0 of true -> 1; false -> -1 end) -> false;
                true -> check_loop_cycle(Next1, Start, Nums, N, Direction, Visited1)
            end
    end.

check_loop_cycle(Current, Start, Nums, N, Direction, Visited) ->
    if
        Current =:= Start -> true;
        true ->
            case array:get(Current, Visited) of
                true -> false;
                false ->
                    Visited1 = array:set(Current, true, Visited),
                    Next = (Current + lists:nth(Current + 1, Nums)) rem N,
                    Next1 = if Next < 0 -> Next + N; true -> Next end,
                    if
                        Next1 =:= Current -> false;
                        Direction =/= (case lists:nth(Next1 + 1, Nums) > 0 of true -> 1; false -> -1 end) -> false;
                        true -> check_loop_cycle(Next1, Start, Nums, N, Direction, Visited1)
                    end
            end
    end.