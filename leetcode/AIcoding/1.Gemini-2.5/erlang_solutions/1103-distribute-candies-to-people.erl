-module(solution).
-export([distributeCandies/2]).

distributeCandies(Candies, NumPeople) ->
    InitialPeopleCandies = lists:duplicate(NumPeople, 0),
    distribute(Candies, InitialPeopleCandies, 0, 1, NumPeople).

distribute(RemainingCandies, PeopleCandies, CurrentPersonIdx, CandiesToGive, NumPeople) ->
    if
        RemainingCandies =< 0 ->
            PeopleCandies;
        true ->
            ActualCandiesToGive = min(RemainingCandies, CandiesToGive),
            NewRemainingCandies = RemainingCandies - ActualCandiesToGive,

            CurrentPersonCandies = lists:nth(CurrentPersonIdx + 1, PeopleCandies),
            UpdatedPersonCandies = CurrentPersonCandies + ActualCandiesToGive,
            NewPeopleCandies = lists:replace_nth(CurrentPersonIdx + 1, UpdatedPersonCandies, PeopleCandies),

            NewCurrentPersonIdx = (CurrentPersonIdx + 1) rem NumPeople,
            NewCandiesToGive = CandiesToGive + 1,

            distribute(NewRemainingCandies, NewPeopleCandies, NewCurrentPersonIdx, NewCandiesToGive, NumPeople)
    end.