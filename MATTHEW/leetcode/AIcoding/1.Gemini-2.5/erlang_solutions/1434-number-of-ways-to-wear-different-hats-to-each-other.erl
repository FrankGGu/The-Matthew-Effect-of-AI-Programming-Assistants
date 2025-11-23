-module(solution).
-export([number_of_ways/1]).

-define(MOD, 1000000007).

number_of_ways(Hats) ->
    N = length(Hats),
    {MaxHatId, HatToPeopleMap} = preprocess_hats(Hats),
    dp(1, MaxHatId, HatToPeopleMap, #{0 => 1}, N).

dp(HatId, MaxHatId, HatToPeopleMap, CurrentDp, N) when HatId > MaxHatId ->
    TargetMask = (1 bsl N) - 1,
    maps:get(TargetMask, CurrentDp, 0);
dp(HatId, MaxHatId, HatToPeopleMap, CurrentDp, N) ->
    NewDp = CurrentDp,
    PeopleWhoLikeHat = maps:get(HatId, HatToPeopleMap, []),
    UpdatedDp = lists:foldl(
        fun(Mask, AccDp) ->
            Count = maps:get(Mask, CurrentDp),
            lists:foldl(
                fun(PersonId, InnerAccDp) ->
                    if (Mask band (1 bsl PersonId)) == 0 ->
                        NewMask = Mask bor (1 bsl PersonId),
                        CurrentCountForNewMask = maps:get(NewMask, InnerAccDp, 0),
                        maps:put(NewMask, (CurrentCountForNewMask + Count) rem ?MOD, InnerAccDp);
                    true ->
                        InnerAccDp
                    end
                end,
                AccDp,
                PeopleWhoLikeHat
            )
        end,
        NewDp,
        maps:keys(CurrentDp)
    ),
    dp(HatId + 1, MaxHatId, HatToPeopleMap, UpdatedDp, N).

preprocess_hats(Hats) ->
    MaxHatId = 0,
    HatToPeopleMap = #{},
    {FinalMaxHatId, FinalHatToPeopleMap, _} = lists:foldl(
        fun(PersonHats, {CurrentMaxHatId, CurrentHatToPeopleMap, PersonIdx}) ->
            {NewMaxHatId, NewHatToPeopleMap} = lists:foldl(
                fun(HatId, {InnerMaxHatId, InnerHatToPeopleMap}) ->
                    PeopleList = maps:get(HatId, InnerHatToPeopleMap, []),
                    UpdatedPeopleList = [PersonIdx | PeopleList],
                    {max(InnerMaxHatId, HatId), maps:put(HatId, UpdatedPeopleList, InnerHatToPeopleMap)}
                end,
                {CurrentMaxHatId, CurrentHatToPeopleMap},
                PersonHats
            ),
            {NewMaxHatId, NewHatToPeopleMap, PersonIdx + 1}
        end,
        {MaxHatId, HatToPeopleMap, 0},
        Hats
    ),
    {FinalMaxHatId, FinalHatToPeopleMap}.