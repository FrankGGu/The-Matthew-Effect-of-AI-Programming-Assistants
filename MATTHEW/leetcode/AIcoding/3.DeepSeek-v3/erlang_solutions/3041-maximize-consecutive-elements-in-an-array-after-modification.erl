-module(solution).
-export([maximize_consecutive_elements/1]).

maximize_consecutive_elements(Nums) ->
    Sorted = lists:sort(Nums),
    Length = length(Sorted),
    DP = array:new([{size, Length}, {default, 1}]),
    {DP1, Max} = lists:foldl(fun(I, {DPAcc, MaxAcc}) ->
        case I > 0 andalso (lists:nth(I, Sorted) =:= lists:nth(I - 1, Sorted) + 1) of
            true ->
                Val = array:get(I - 1, DPAcc) + 1,
                DPAcc1 = array:set(I, Val, DPAcc),
                {DPAcc1, max(MaxAcc, Val)};
            false ->
                case I > 0 andalso (lists:nth(I, Sorted) =:= lists:nth(I - 1, Sorted)) of
                    true ->
                        Val = array:get(I - 1, DPAcc),
                        DPAcc1 = array:set(I, Val, DPAcc),
                        {DPAcc1, max(MaxAcc, Val)};
                    false ->
                        {DPAcc, MaxAcc}
                end
        end
    end, {DP, 1}, lists:seq(1, Length - 1)),
    Max.