-module(solution).
-export([min_extra_char/2]).

min_extra_char(S, Dict) ->
    DictSet = sets:from_list(Dict),
    N = length(S),
    DP = array:new([{size, N + 1}, {default, N}]),
    DP1 = array:set(0, 0, DP),
    {_, Result} = lists:foldl(fun(I, {DPAcc, _}) ->
        lists:foldl(fun(J, {DPIn, _}) ->
            SubStr = string:sub_string(S, J + 1, I),
            case sets:is_element(SubStr, DictSet) of
                true ->
                    Min = min(array:get(I, DPIn), array:get(J, DPIn)),
                    {array:set(I, Min, DPIn), Min};
                false ->
                    {DPIn, array:get(I, DPIn)}
            end
        end, {DPAcc, array:get(I, DPAcc)}, lists:seq(I - 1, max(I - 20, -1), -1))
    end, {DP1, N}, lists:seq(1, N)),
    Result.