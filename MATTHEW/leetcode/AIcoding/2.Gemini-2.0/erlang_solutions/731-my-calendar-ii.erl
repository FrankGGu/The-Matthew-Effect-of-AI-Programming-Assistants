-module(my_calendar_ii).
-export([new/0, book/2]).

new() ->
    {[], []}.

book({Bookings, Overlaps}, Start, End) ->
    case check_overlap(Overlaps, Start, End) of
        true ->
            false;
        false ->
            case find_new_overlaps(Bookings, Start, End) of
                [] ->
                    {[{Start, End} | Bookings], Overlaps};
                NewOverlaps ->
                    {[{Start, End} | Bookings], lists:usort(Overlaps ++ NewOverlaps)};
            end
    end.

check_overlap(Overlaps, Start, End) ->
    lists:any(fun({OverlapStart, OverlapEnd}) ->
                      not (OverlapEnd =< Start orelse End =< OverlapStart)
              end, Overlaps).

find_new_overlaps(Bookings, Start, End) ->
    lists:foldl(fun({BookingStart, BookingEnd}, Acc) ->
                      NewStart = max(Start, BookingStart),
                      NewEnd = min(End, BookingEnd),
                      case NewStart < NewEnd of
                          true ->
                              [{NewStart, NewEnd} | Acc];
                          false ->
                              Acc
                      end
              end, [], Bookings).