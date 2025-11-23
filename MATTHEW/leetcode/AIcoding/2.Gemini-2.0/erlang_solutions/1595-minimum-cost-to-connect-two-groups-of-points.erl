-module(minimum_cost_connect_two_groups).
-export([mcm/3]).

mcm(Cost, N1, N2) ->
    memo(Cost, N1, N2).

memo(Cost, N1, N2) ->
    MinCost = lists:map(fun(X) -> lists:min(X) end, lists:transpose(Cost)),

    memo(Cost, N2, MinCost, 0, or_list(N2, 0), dict:new()).

memo(Cost, N2, MinCost, Mask, Seen, Cache) ->
    case dict:is_key(Mask, Cache) of
        true -> dict:fetch(Mask, Cache);
        false ->
            case Mask == or_list(N2, 1) of
                true -> 0;
                false ->
                    Result = 
                        lists:foldl(
                            fun(I, Acc) ->
                                case (Mask bsr I) band 1 of
                                    0 ->
                                        lists:foldl(
                                            fun(J, InnerAcc) ->
                                                NewMask = Mask bor (1 bsl I),
                                                CostIJ = lists:nth(I, lists:nth(J, Cost)) + memo(Cost, N2, MinCost, NewMask, Seen, Cache),
                                                min(InnerAcc, CostIJ)
                                            end,
                                            Acc,
                                            lists:seq(1, length(Cost))
                                        );
                                    1 ->
                                        Acc
                                end
                            end,
                            infinity,
                            lists:seq(0, N2-1)
                        ),
                    NewCache = dict:store(Mask, Result, Cache),
                    NewCache = dict:store(Mask, Result, Cache),
                    Result
            end
    end.

or_list(N, Val) ->
    lists:foldl(
        fun(_, Acc) ->
            Acc bor (Val bsl 0)
        end,
        0,
        lists:seq(1, N)
    ).

infinity() ->
    1000000000.