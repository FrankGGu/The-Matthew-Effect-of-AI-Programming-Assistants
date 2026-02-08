-spec decompress_rl_elist(Nums :: [integer()]) -> [integer()].
decompress_rl_elist(Nums) ->
    decompress_rl_elist(Nums, []).

decompress_rl_elist([], Acc) ->
    lists:reverse(Acc);
decompress_rl_elist([Freq, Val | Rest], Acc) ->
    decompress_rl_elist(Rest, lists:reverse(lists:duplicate(Freq, Val)) ++ Acc).