-module(solution).
-export([minimum_cost/4]).

minimum_cost(Source, Target, Original, Changed, Cost) ->
    {OriginalList, ChangedList, CostList} = {Original, Changed, Cost},
    CostMap = build_cost_map(OriginalList, ChangedList, CostList),
    calculate_min_cost(Source, Target, CostMap).

build_cost_map(Original, Changed, Cost) ->
    lists:foldl(fun({O, C, Co}, Map) ->
                    maps:put({O, C}, Co, Map)
                end, #{}, lists:zip3(Original, Changed, Cost)).

calculate_min_cost(Source, Target, CostMap) ->
    {SourceChars, TargetChars} = {unicode:characters_to_list(Source), unicode:characters_to_list(Target)},
    lists:foldl(fun({S, T}, Acc) ->
                    if
                        S =:= T -> Acc;
                        true ->
                            case maps:get({S, T}, CostMap, infinity) of
                                infinity -> infinity;
                                Cost -> Acc + Cost
                            end
                    end
                end, 0, lists:zip(SourceChars, TargetChars)).