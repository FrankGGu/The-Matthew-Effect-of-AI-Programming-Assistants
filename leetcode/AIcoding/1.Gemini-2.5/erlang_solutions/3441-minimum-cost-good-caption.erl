-module(solution).
-export([min_cost_good_caption/3]).

-define(INF, 1_000_000_000).

min_cost_good_caption(TargetString, Words, Costs) ->
    WordCostMap = maps:from_list(lists:zip(Words, Costs)),
    N = length(TargetString),

    DPArray = array:new([{size, N + 1}, {fixed, true}, {default, ?INF}]),
    DPArray0 = array:set(0, 0, DPArray),

    FinalDPArray =
        lists:foldl(
            fun(I, CurrentDPArray) ->
                CostToReachI = array:get(I, CurrentDPArray),
                if CostToReachI == ?INF ->
                    CurrentDPArray;
                true ->
                    lists:foldl(
                        fun(J, InnerDPArray) ->
                            Substr = lists:sublist(TargetString, I + 1, J - I),

                            case maps:find(Substr, WordCostMap) of
                                {ok, WordCost} ->
                                    NewCostForJ = CostToReachI + WordCost,
                                    ExistingCostForJ = array:get(J, InnerDPArray),

                                    if NewCostForJ < ExistingCostForJ ->
                                        array:set(J, NewCostForJ, InnerDPArray);
                                    true ->
                                        InnerDPArray
                                    end;
                                error ->
                                    InnerDPArray
                            end
                        end,
                        CurrentDPArray,
                        lists:seq(I + 1, N)
                    )
                end
            end,
            DPArray0,
            lists:seq(0, N - 1)
        ),

    Result = array:get(N, FinalDPArray),

    if Result == ?INF ->
        -1;
    true ->
        Result
    end.