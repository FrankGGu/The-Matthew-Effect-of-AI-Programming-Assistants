-module(solution).
-export([find_all_people/3]).

find_all_people(N, Meetings, FirstPerson) ->
    Parent = array:new([{size, N}, {default, -1}]),
    Parent1 = array:set(0, 0, Parent),
    Parent2 = array:set(FirstPerson, FirstPerson, Parent1),
    SortedMeetings = lists:sort(fun([_, _, T1], [_, _, T2]) -> T1 =< T2 end, Meetings),
    process_meetings(SortedMeetings, Parent2, N).

process_meetings([], Parent, _N) ->
    lists:filter(fun(I) -> array:get(I, Parent) =:= I end, lists:seq(0, array:size(Parent) - 1));
process_meetings(Meetings, Parent, N) ->
    {CurrentTimeMeetings, Rest} = lists:splitwith(fun([_, _, T]) -> T =:= hd(hd(Meetings)) end, Meetings),
    People = lists:usort(lists:append([[X, Y] || [X, Y, _] <- CurrentTimeMeetings])),
    TempParent = lists:foldl(fun(P, Acc) -> array:set(P, P, Acc) end, Parent, People),
    UpdatedParent = lists:foldl(fun([X, Y, _], Acc) -> union(X, Y, Acc) end, TempParent, CurrentTimeMeetings),
    Roots = [find(X, UpdatedParent) || X <- People],
    Connected = lists:usort(Roots),
    NewParent = lists:foldl(fun(P, Acc) ->
        case lists:member(find(P, UpdatedParent), Connected) of
            true -> array:set(P, find(P, UpdatedParent), Acc);
            false -> array:set(P, -1, Acc)
        end
    end, Parent, People),
    process_meetings(Rest, NewParent, N).

find(X, Parent) ->
    case array:get(X, Parent) of
        -1 -> -1;
        X -> X;
        P -> find(P, Parent)
    end.

union(X, Y, Parent) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if
        RootX =/= RootY ->
            array:set(RootY, RootX, Parent);
        true ->
            Parent
    end.