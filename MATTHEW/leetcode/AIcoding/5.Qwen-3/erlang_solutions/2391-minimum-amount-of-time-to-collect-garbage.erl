-module(solution).
-export([garbage_collection/2]).

garbage_collection(Garbage, Travel) ->
    TotalTime = 0,
    {_, _, _, Time} = lists:foldl(fun(Worker, {Total, GarbageList, TravelList, Acc}) ->
        case Worker of
            "G" -> {Total + hd(GarbageList), tl(GarbageList), TravelList, Acc + travel_time(TravelList, 0)};
            "P" -> {Total + hd(GarbageList), tl(GarbageList), TravelList, Acc + travel_time(TravelList, 1)};
            "M" -> {Total + hd(GarbageList), tl(GarbageList), TravelList, Acc + travel_time(TravelList, 2)}
        end
    end, {0, Garbage, Travel, 0}, ["G", "P", "M"]),
    Time.

travel_time([], _) -> 0;
travel_time([H | T], Index) ->
    if Index == 0 -> H + travel_time(T, Index);
       Index == 1 -> H + travel_time(T, Index);
       Index == 2 -> H + travel_time(T, Index)
    end.