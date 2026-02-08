-module(solution).
-export([full_bloom_flowers/2]).

full_bloom_flowers(Flowers, People) ->
    Events = create_events(Flowers, People),
    SortedEvents = lists:sort(Events),
    process_events(SortedEvents, array:new(length(People), {default, 0}), 0).

create_events(Flowers, People) ->
    FlowerEvents = lists:flatmap(fun([S, E]) -> [{S, 1, 0}, {E + 1, 3, 0}] end, Flowers),
    PeopleEvents = lists:mapi(fun(Time, Index) -> {Time, 2, Index} end, People),
    FlowerEvents ++ PeopleEvents.

process_events([{Time, Type, Index} | Rest], ResultsArray, CurrentBloomCount) ->
    NewBloomCount = case Type of
        1 -> CurrentBloomCount + 1;
        3 -> CurrentBloomCount - 1;
        2 -> CurrentBloomCount
    end,
    NewResultsArray = case Type of
        2 -> array:set(Index, NewBloomCount, ResultsArray);
        _ -> ResultsArray
    end,
    process_events(Rest, NewResultsArray, NewBloomCount);
process_events([], ResultsArray, _) ->
    array:to_list(ResultsArray).