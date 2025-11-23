-module(solution).
-export([number_ways/1]).

number_ways(Hats) ->
    PeopleHats = lists:foldl(fun(PersonIndex, Acc) ->
                                    lists:foldl(fun(Hat, Map) ->
                                                        maps:update_with(Hat, fun(People) -> [PersionIndex | People] end, [PersionIndex], Map)
                                                end, Acc, lists:nth(PersionIndex + 1, Hats))
                            end, maps:new(), lists:seq(0, length(Hats) - 1)),
    HatsList = lists:sort(maps:keys(PeopleHats)),
    DP = maps:from_list([{0, 1}]),
    lists:foldl(fun(Hat, Dp) ->
                        People = maps:get(Hat, PeopleHats),
                        maps:fold(fun(Mask, Count, Acc) ->
                                          lists:foldl(fun(Person, InnerAcc) ->
                                                               case (Mask band (1 bsl Person)) =:= 0 of
                                                                   true ->
                                                                       NewMask = Mask bor (1 bsl Person),
                                                                       maps:update_with(NewMask, fun(C) -> (C + Count) rem 1000000007 end, Count, InnerAcc);
                                                                   false ->
                                                                       InnerAcc
                                                               end
                                                       end, Acc, People)
                                  end, Dp, Dp)
                end, DP, HatsList),
    case maps:get((1 bsl length(Hats)) - 1, DP, 0) of
        undefined -> 0;
        Val -> Val
    end.