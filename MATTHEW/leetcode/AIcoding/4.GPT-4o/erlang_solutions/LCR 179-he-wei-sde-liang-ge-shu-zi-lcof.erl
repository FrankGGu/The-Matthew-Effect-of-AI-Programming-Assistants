-module(solution).
-export([two_sum/2]).

two_sum(Prices, Target) ->
    Map = maps:from_list([{X, Index} || {X, Index} <- lists:zip(Prices, lists:seq(1, length(Prices)))]),
    find_pair(Prices, Target, Map, 1).

find_pair([], _, _, _) -> [];
find_pair([H | T], Target, Map, Index) ->
    case maps:is_key(Target - H, Map) of
        true -> [Index, maps:get(Target - H, Map)];
        false -> find_pair(T, Target, Map, Index + 1)
    end.