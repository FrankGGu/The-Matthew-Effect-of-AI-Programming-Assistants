-spec top_k_frequent(Nums :: [integer()], K :: integer()) -> [integer()].

top_k_frequent(Nums, K) ->
    Nums
    |> lists:foldl(fun(N, Acc) -> 
                        case lists:keyfind(N, 1, Acc) of
                            false -> [{N, 1} | Acc];
                            {N, Freq} -> lists:keyreplace(N, 1, Acc, {N, Freq + 1})
                        end
                    end, [])
    |> lists:sort(fun({_, Freq1}, {_, Freq2}) -> Freq1 > Freq2 end)
    |> lists:sublist(K)
    |> lists:map(fun({N, _}) -> N end).
