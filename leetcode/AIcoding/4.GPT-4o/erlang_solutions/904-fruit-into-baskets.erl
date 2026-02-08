-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    total_fruit(Fruits, 0, 0, 0, 0, #{}, 0).

total_fruit([], _, Max, _, Result, _, Result);
total_fruit([H|T], Start, End, Count, Result, Map, Max) ->
    NewCount = Count + 1,
    NewMap = maps:update(H, 1, fun(X) -> X + 1 end, Map),
    NewEnd = if maps:size(NewMap) =< 2 -> End + 1; true -> End end,
    NewMax = max(Max, NewEnd),
    if NewEnd =< End ->
        total_fruit(T, Start + 1, NewEnd, NewCount, NewMax, NewMap, Max);
    true ->
        case maps:size(NewMap) of
            3 -> 
                NewStart = find_start(Fruits, Start, NewMap),
                total_fruit(T, NewStart + 1, NewEnd, 0, NewMax, maps:remove(hd(lists:nth(NewStart, Fruits)), NewMap), NewMax);
            _ -> 
                total_fruit(T, Start, NewEnd, NewCount, NewMax, NewMap, Max)
        end
    end.

find_start(Fruits, Start, Map) ->
    case maps:to_list(Map) of
        [{K1, V1}, {K2, V2}] -> Start;
        [{K1, _}] -> Start;
        _ -> Start
    end.