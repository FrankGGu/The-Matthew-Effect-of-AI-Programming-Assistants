-module(solution).
-export([smallest_chair/2]).

smallest_chair(Times, TargetFriend) ->
    N = length(Times),
    Friends = lists:zip(lists:seq(0, N - 1), Times),
    SortedFriends = lists:sort(fun({_, [A1, _]}, {_, [A2, _]}) -> A1 =< A2 end, Friends),
    Available = lists:seq(0, N - 1),
    {_, ChairMap, _} = lists:foldl(fun({Friend, [Arrival, Leaving]}, {AvailableChairs, Occupied, TimeHeap}) ->
        {NewTimeHeap, NewOccupied} = process_leaving(TimeHeap, Occupied, Arrival),
        case Friend =:= TargetFriend of
            true ->
                [Chair | Rest] = AvailableChairs,
                {Rest, maps:put(Chair, Leaving, NewOccupied), [{Leaving, Chair} | NewTimeHeap]};
            false ->
                [Chair | Rest] = AvailableChairs,
                {Rest, maps:put(Chair, Leaving, NewOccupied), [{Leaving, Chair} | NewTimeHeap]}
        end
    end, {Available, #{}, []}, SortedFriends),
    maps:get(TargetFriend, ChairMap).

process_leaving(TimeHeap, Occupied, CurrentTime) ->
    {LeavingHeap, FreedChairs} = lists:partition(fun({Leave, _}) -> Leave > CurrentTime end, TimeHeap),
    Freed = lists:map(fun({_, Chair}) -> Chair end, FreedChairs),
    NewOccupied = lists:foldl(fun(Chair, Acc) -> maps:remove(Chair, Acc) end, Occupied, Freed),
    {LeavingHeap, NewOccupied}.