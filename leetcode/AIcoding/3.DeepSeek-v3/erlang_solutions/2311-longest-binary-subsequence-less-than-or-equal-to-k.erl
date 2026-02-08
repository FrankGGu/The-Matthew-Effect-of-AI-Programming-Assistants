-spec longest_subsequence(S :: unicode:unicode_binary(), K :: integer()) -> integer().
longest_subsequence(S, K) ->
    Bin = binary_to_list(S),
    N = length(Bin),
    DP = array:new([{size, N + 1}, {default, 0}]),
    {DP1, _} = lists:foldl(fun(I, {DPAcc, Prev}) ->
        Char = lists:nth(I, Bin),
        Val = (Prev bsl 1) bor (Char - $0),
        if
            Val =< K ->
                DPNew = array:set(I, Val, DPAcc),
                {DPNew, Val};
            true ->
                DPNew = array:set(I, Prev, DPAcc),
                {DPNew, Prev}
        end
    end, {DP, 0}, lists:seq(1, N)),
    lists:foldl(fun(I, Acc) ->
        case array:get(I, DP1) of
            0 -> Acc;
            _ -> Acc + 1
        end
    end, 0, lists:seq(1, N)).