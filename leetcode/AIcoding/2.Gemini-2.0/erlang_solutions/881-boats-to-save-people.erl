-module(boats_to_save_people).
-export([numRescueBoats/2]).

numRescueBoats(People, Limit) ->
    SortedPeople = lists:sort(People),
    numRescueBoatsHelper(SortedPeople, Limit, 0).

numRescueBoatsHelper([], _Limit, Acc) ->
    Acc;
numRescueBoatsHelper([H|T], Limit, Acc) ->
    case findPartner(H, T, Limit) of
        {Found, Rest} ->
            if Found == true then
                numRescueBoatsHelper(Rest, Limit, Acc + 1)
            else
                numRescueBoatsHelper(T, Limit, Acc + 1)
            end;
        false ->
            numRescueBoatsHelper(T, Limit, Acc + 1)
    end.

findPartner(H, [X|T], Limit) ->
    if H + X =< Limit then
        {true, T}
    else
        case T of
            [] ->
                false;
            _ ->
                 findPartner(H, T, Limit)
        end
    end;
findPartner(_H, [], _Limit) ->
    false.