-spec count_black_blocks(M :: integer(), N :: integer(), Coordinates :: [[integer()]]) -> [integer()].
count_black_blocks(M, N, Coordinates) ->
    CoordSet = sets:from_list([{X, Y} || [X, Y] <- Coordinates]),
    Counts = array:new(5, {default, 0}),
    Processed = sets:new(),
    lists:foreach(
        fun([X, Y]) ->
            lists:foreach(
                fun({I, J}) ->
                    if
                        I >= 0, I < M - 1, J >= 0, J < N - 1 ->
                            Key = {I, J},
                            case sets:is_element(Key, Processed) of
                                false ->
                                    Black = count_black_in_block(I, J, CoordSet),
                                    Counts1 = array:set(Black, array:get(Black, Counts) + 1, Counts),
                                    Processed1 = sets:add_element(Key, Processed),
                                    {Counts1, Processed1};
                                true ->
                                    {Counts, Processed}
                            end;
                        true ->
                            {Counts, Processed}
                    end
                end,
                [{X-1, Y-1}, {X-1, Y}, {X, Y-1}, {X, Y}]
            )
        end,
        Coordinates
    ),
    Total = (M - 1) * (N - 1),
    Black0 = Total - array:get(1, Counts) - array:get(2, Counts) - array:get(3, Counts) - array:get(4, Counts),
    [Black0, array:get(1, Counts), array:get(2, Counts), array:get(3, Counts), array:get(4, Counts)].

count_black_in_block(I, J, CoordSet) ->
    lists:foldl(
        fun({X, Y}, Acc) ->
            case sets:is_element({X, Y}, CoordSet) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        [{I, J}, {I, J+1}, {I+1, J}, {I+1, J+1}]
    ).