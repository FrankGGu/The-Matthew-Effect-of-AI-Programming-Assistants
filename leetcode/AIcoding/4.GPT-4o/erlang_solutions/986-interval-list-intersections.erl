-module(solution).
-export([intervalIntersection/2]).

intervalIntersection(FirstList, SecondList) ->
    intervalIntersection(FirstList, SecondList, []).

intervalIntersection([], _, Acc) ->
    lists:reverse(Acc);
intervalIntersection(_, [], Acc) ->
    lists:reverse(Acc);
intervalIntersection([{Start1, End1} | Rest1], [{Start2, End2} | Rest2], Acc) ->
    if
        End1 < Start2 -> 
            intervalIntersection(Rest1, [{Start2, End2} | Rest2], Acc);
        End2 < Start1 -> 
            intervalIntersection([{Start1, End1} | Rest1], Rest2, Acc);
        true -> 
            NewStart = lists:max([Start1, Start2]),
            NewEnd = lists:min([End1, End2]),
            intervalIntersection(Rest1, Rest2, [{NewStart, NewEnd} | Acc])
    end.