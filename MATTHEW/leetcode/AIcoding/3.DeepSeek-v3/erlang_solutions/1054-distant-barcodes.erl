-spec rearrange_barcodes(Barcodes :: [integer()]) -> [integer()].
rearrange_barcodes(Barcodes) ->
    Counts = lists:foldl(fun(X, Acc) -> 
                            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) 
                         end, #{}, Barcodes),
    Sorted = lists:sort(fun({K1, V1}, {K2, V2}) -> 
                            if V1 =:= V2 -> K1 > K2;
                               true -> V1 > V2
                            end
                         end, maps:to_list(Counts)),
    N = length(Barcodes),
    Result = lists:duplicate(N, 0),
    {Result1, _} = lists:foldl(fun({K, V}, {Res, Pos}) ->
                                    {Res1, Pos1} = lists:foldl(fun(_, {R, P}) ->
                                        case P >= N of
                                            true -> {R, 1};
                                            false -> {R, P}
                                        end,
                                        NewR = setelement(P, R, K),
                                        {NewR, P + 2}
                                    end, {Res, Pos}, lists:seq(1, V)),
                                    {Res1, Pos1}
                               end, {list_to_tuple(Result), 1}, Sorted),
    tuple_to_list(Result1).