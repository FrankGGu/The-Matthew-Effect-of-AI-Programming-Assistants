-module(my_calendar_ii).
-export([new/0, book/3]).

new() ->
    [].

book(Bookings, Start, End) ->
    ExistingBookingPoints = lists:foldl(
        fun({S, E}, Acc) -> [{S, 1}, {E, -1} | Acc] end,
        [],
        Bookings
    ),

    AllPoints = [{Start, 1}, {End, -1} | ExistingBookingPoints],

    SortedPoints = lists:sort(
        fun({T1, Type1}, {T2, Type2}) ->
            if
                T1 < T2 -> true;
                T1 > T2 -> false;
                T1 == T2 -> Type1 > Type2
            end
        end,
        AllPoints
    ),

    IsTripleBooked = check_triple_booking(SortedPoints, 0),

    if
        IsTripleBooked ->
            {false, Bookings};
        true ->
            {true, [{Start, End} | Bookings]}
    end.

check_triple_booking([{_Time, Type} | Rest], CurrentOverlapCount) ->
    NewOverlapCount = CurrentOverlapCount + Type,
    if
        NewOverlapCount > 2 ->
            true;
        true ->
            check_triple_booking(Rest, NewOverlapCount)
    end;
check_triple_booking([], _CurrentOverlapCount) ->
    false.