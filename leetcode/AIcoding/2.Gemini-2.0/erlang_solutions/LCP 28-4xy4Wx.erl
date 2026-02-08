-module(solution).
-export([number_of_ways/2]).

number_of_ways(Nums, Target) ->
    lists:foldl(fun(X, Acc) ->
                        lists:foldl(fun(Y, Acc2) ->
                                        case X + Y =< Target and X =< Y of
                                            true -> Acc2 + 1;
                                            false -> Acc2
                                        end
                                    end, Acc, Nums)
                    end, 0, lists:usort(Nums)) div 2 + lists:foldl(fun(X, Acc) ->
                                                                       case X + X =< Target of
                                                                           true -> Acc + 1;
                                                                           false -> Acc
                                                                       end
                                                                   end, 0, lists:usort(Nums)) rem 2.