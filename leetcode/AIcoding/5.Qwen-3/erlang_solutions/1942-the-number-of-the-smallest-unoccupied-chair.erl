-module(solution).
-export([kth_smallest_unoccupied_chair/2]).

kth_smallest_unoccupied_chair(People, K) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, People),
    Events = lists:foldl(fun({Arrival, Leaving}, Acc) ->
        [{arrival, Arrival, 0} | [{leaving, Leaving, 0} | Acc]]
    end, [], Sorted),
    SortedEvents = lists:sort(fun({Type1, Time1, _}, {Type2, Time2, _}) ->
        case Time1 == Time2 of
            true -> Type1 == arrival;
            false -> Time1 < Time2
        end
    end, Events),
    Chairs = [],
    kth_smallest_unoccupied_chair(SortedEvents, Chairs, K).

kth_smallest_unoccupied_chair([], _, _) -> -1;
kth_smallest_unoccupied_chair([{arrival, Time, _} | Rest], Chairs, K) ->
    if
        Chairs /= [] ->
            [Chair | NewChairs] = Chairs,
            kth_smallest_unoccupied_chair(Rest, NewChairs ++ [Chair], K);
        true ->
            kth_smallest_unoccupied_chair(Rest, [1], K)
    end;
kth_smallest_unoccupied_chair([{leaving, Time, Chair} | Rest], Chairs, K) ->
    kth_smallest_unoccupied_chair(Rest, [Chair | Chairs], K).