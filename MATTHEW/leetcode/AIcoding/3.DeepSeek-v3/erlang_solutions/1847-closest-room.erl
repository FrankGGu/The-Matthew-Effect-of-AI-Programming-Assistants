-module(solution).
-export([closest_room/2]).

closest_room(Rooms, Queries) ->
    SortedRooms = lists:sort(fun([Id1, Size1], [Id2, Size2]) ->
        if Size1 =:= Size2 -> Id1 =< Id2;
           true -> Size1 >= Size2
        end
    end, Rooms),
    lists:map(fun([Preferred, MinSize]) ->
        find_closest(SortedRooms, Preferred, MinSize)
    end, Queries).

find_closest([], _Preferred, _MinSize) -> -1;
find_closest([[Id, Size] | Rest], Preferred, MinSize) ->
    if Size < MinSize -> -1;
       true ->
            Diff = abs(Id - Preferred),
            case find_closest(Rest, Preferred, MinSize) of
                -1 -> Id;
                OtherId ->
                    OtherDiff = abs(OtherId - Preferred),
                    if Diff < OtherDiff -> Id;
                       Diff =:= OtherDiff andalso Id < OtherId -> Id;
                       true -> OtherId
                    end
            end
    end.