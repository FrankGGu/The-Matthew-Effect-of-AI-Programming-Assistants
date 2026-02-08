-module(maximum_earnings_from_taxi).
-export([max_taxi_earnings/2]).

max_taxi_earnings(N, Rides) ->
    SortedRides = lists:sort(fun({S1, _, _}, {S2, _, _}) -> S1 < S2 end, Rides),
    memo(SortedRides, maps:new()).

memo([], Memo) ->
    maps:get(0, Memo, 0);
memo([{Start, End, Tip} | Rest], Memo) ->
    case maps:is_key(Start, Memo) of
        true ->
            maps:get(Start, Memo);
        false ->
            NotTake = memo(Rest, Memo),
            Take = End - Start + Tip + memo(find_next(End, Rest), Memo),
            Max = max(Take, NotTake),
            NewMemo = maps:put(Start, Max, Memo),
            Max
    end.

find_next(End, Rides) ->
    find_next_helper(End, Rides, []).

find_next_helper(_End, [], Acc) ->
    Acc;
find_next_helper(End, [{Start, _, _} | Rest], Acc) ->
    case Start >= End of
        true ->
            [ {Start, A, B} | Rest1] = [{Start1, A1, B1} || {Start1, A1, B1} <- [{Start, _, _} | Rest], Start1 >= End],
            Rest1;
        false ->
            find_next_helper(End, Rest, Acc)
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.