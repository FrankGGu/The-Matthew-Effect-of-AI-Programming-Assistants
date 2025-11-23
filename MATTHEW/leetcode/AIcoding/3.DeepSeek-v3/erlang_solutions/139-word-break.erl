-spec word_break(S :: unicode:unicode_binary(), WordDict :: [unicode:unicode_binary()]) -> boolean().
word_break(S, WordDict) ->
    WordSet = sets:from_list(WordDict),
    N = byte_size(S),
    DP = array:new([{size, N + 1}, {default, false}]),
    DP1 = array:set(0, true, DP),
    {Result, _} = lists:foldl(fun(I, {DPAcc, _}) ->
        lists:foldl(fun(J, {DPInner, Found}) ->
            case Found of
                true -> {DPInner, true};
                false ->
                    Sub = binary:part(S, J, I - J),
                    case sets:is_element(Sub, WordSet) andalso array:get(J, DPInner) of
                        true -> {array:set(I, true, DPInner), true};
                        false -> {DPInner, false}
                    end
            end
        end, {DPAcc, false}, lists:seq(0, I - 1))
    end, {DP1, false}, lists:seq(1, N)),
    array:get(N, Result).