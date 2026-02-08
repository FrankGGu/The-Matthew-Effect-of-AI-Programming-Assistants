-module(solution).
-export([special_integer/1]).

-spec special_integer(Arr :: [integer()]) -> integer().
special_integer(Arr) ->
    N = length(Arr),
    Threshold = N div 4,
    find_special(tl(Arr), hd(Arr), 1, Threshold).

find_special([], CurrentElement, _Count, _Threshold) ->
    CurrentElement;
find_special([H|T], CurrentElement, Count, Threshold) ->
    if
        H == CurrentElement ->
            NewCount = Count + 1,
            if
                NewCount > Threshold ->
                    CurrentElement;
                true ->
                    find_special(T, CurrentElement, NewCount, Threshold)
            end;
        true ->
            find_special(T, H, 1, Threshold)
    end.