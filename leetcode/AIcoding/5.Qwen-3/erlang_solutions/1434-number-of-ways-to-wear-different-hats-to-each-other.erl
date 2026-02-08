-module(ways_to_wear_hats).
-export([numberWays/1]).

numberWays(Hats) ->
    HatsList = lists:map(fun(X) -> lists:sort(X) end, Hats),
    HatToPeople = maps:from_list([{H, [P || P <- lists:seq(0, length(HatsList)-1), lists:member(H, lists:nth(P+1, HatsList))]} || H <- lists:usort(lists:flatten(HatsList))]),
    PeopleCount = length(HatsList),
    HatList = maps:keys(HatToPeople),
    dp(PeopleCount, HatList, HatToPeople, 0, 0).

dp(_, [], _, _, Acc) -> Acc;
dp(PeopleCount, [H|T], HatToPeople, Bitmask, Acc) ->
    People = maps:get(H, HatToPeople),
    NewAcc = lists:foldl(fun(Person, A) ->
        if (Bitmask band (1 bsl Person)) == 0 ->
            dp(PeopleCount, T, HatToPeople, Bitmask bor (1 bsl Person), A + 1);
        true -> A
        end
    end, Acc, People),
    dp(PeopleCount, T, HatToPeople, Bitmask, NewAcc).