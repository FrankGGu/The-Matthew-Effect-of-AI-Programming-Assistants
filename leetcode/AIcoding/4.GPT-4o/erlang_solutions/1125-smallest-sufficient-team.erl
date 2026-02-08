-module(smallest_sufficient_team).
-export([smallestSufficientTeam/2]).

smallestSufficientTeam(Traits, People) ->
    Teams = lists:map(fun({_, Traits}) -> lists:foldl(fun(Trait, Acc) -> sets:insert(Trait, Acc) end, sets:new(), Traits) end, People),
    PeopleCount = length(People),
    TraitsSet = lists:foldl(fun(Trait, Acc) -> sets:insert(Trait, Acc) end, sets:new(), Traits),
    MinTeam = smallest_team(Teams, TraitsSet, [], PeopleCount),
    lists:sort(MinTeam).

smallest_team(_, TraitsSet, CurrentTeam, MinSize) when sets:size(TraitsSet) == 0 -> 
    CurrentTeam;
smallest_team(Teams, TraitsSet, CurrentTeam, MinSize) ->
    lists:foldl(fun(_, Acc) -> 
        case Acc of 
            {BestTeam, BestSize} -> 
                BestTeam;
            _ -> 
                BestTeam 
        end 
    end, {[], MinSize}, lists:seq(1, length(Teams))).