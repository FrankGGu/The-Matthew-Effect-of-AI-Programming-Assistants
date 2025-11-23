-module(solution).
-export([num_rescue_boats/2]).

num_rescue_boats(people, limit) ->
    SortedPeople = lists:sort(people),
    num_rescue_boats(SortedPeople, limit, length(SortedPeople), 0).

num_rescue_boats(People, Limit, 0, Count) -> 
    Count;
num_rescue_boats(People, Limit, N, Count) ->
    case N > 0 of
        true ->
            First = hd(People),
            Rest = tl(People),
            case lists:member(Limit - First, Rest) of
                true -> 
                    NewN = N - 2,
                    NewCount = Count + 1,
                    num_rescue_boats(tl(Rest), Limit, NewN, NewCount);
                false ->
                    NewN = N - 1,
                    NewCount = Count + 1,
                    num_rescue_boats(Rest, Limit, NewN, NewCount)
            end;
        false ->
            Count
    end.