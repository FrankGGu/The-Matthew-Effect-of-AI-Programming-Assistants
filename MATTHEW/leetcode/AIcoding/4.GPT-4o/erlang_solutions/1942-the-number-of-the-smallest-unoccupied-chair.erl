-module(solution).
-export([smallest_chair/2]).

smallest_chair(Arrival, Seating) ->
    MaxTime = lists:max(Arrival),
    Chairs = lists:duplicate(length(Seating), false),
    lists:foldl(fun(Time, Acc) ->
        case lists:keyfind(Time, 1, Acc) of
            false ->
                Acc;
            {Time, Chair} ->
                Chairs1 = lists:replace(Chair, true, Chairs),
                lists:foldl(fun({_, P}, Acc1) ->
                    if
                        P =< Time ->
                            Acc1;
                        true ->
                            [{P, Chair} | Acc1]
                    end
                end, [], Seating) ++ Chairs1
        end
    end, [], lists:zip(Arrival, lists:seq(1, length(Seating))).