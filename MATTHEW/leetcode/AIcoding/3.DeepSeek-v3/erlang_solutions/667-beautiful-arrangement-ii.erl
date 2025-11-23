-spec construct_array(N :: integer(), K :: integer()) -> [integer()].
construct_array(N, K) ->
    construct_array(N, K, 1, N, []).

construct_array(N, K, Low, High, Acc) when K > 1 ->
    if 
        K rem 2 == 1 -> construct_array(N, K - 1, Low + 1, High, [Low | Acc]);
        true -> construct_array(N, K - 1, Low, High - 1, [High | Acc])
    end;
construct_array(N, _K, Low, High, Acc) ->
    lists:reverse(Acc) ++ lists:seq(Low, High).