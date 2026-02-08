-spec max_value_of_k_coins(Piles :: [[integer()]], K :: integer()) -> integer().
max_value_of_k_coins(Piles, K) ->
    DP = maps:new(),
    DP1 = maps:put({0, 0}, 0, DP),
    {_, Res} = lists:foldl(fun(Pile, {DPAcc, _}) ->
        lists:foldl(fun({I, J}, {DPIn, Max}) ->
            lists:foldl(fun(T, {DPTmp, M}) ->
                case I + T =< K of
                    true ->
                        case maps:get({I, J}, DPTmp, 0) + lists:sum(lists:sublist(Pile, T)) of
                            Val when Val > maps:get({I + T, J + 1}, DPTmp, 0) ->
                                {maps:put({I + T, J + 1}, Val, DPTmp), max(M, Val)};
                            _ ->
                                {DPTmp, M}
                        end;
                    false ->
                        {DPTmp, M}
                end
            end, {DPIn, Max}, lists:seq(0, length(Pile)))
        end, {DPAcc, 0}, maps:to_list(DPAcc))
    end, {DP1, 0}, Piles),
    Res.