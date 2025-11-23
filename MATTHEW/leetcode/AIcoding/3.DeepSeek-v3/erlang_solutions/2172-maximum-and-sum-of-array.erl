-module(solution).
-export([maximum_and_sum/2]).

maximum_and_sum(Nums, NumSlots) ->
    MaxMask = 1 bsl (2 * NumSlots),
    DP = array:new(MaxMask, {default, -1}),
    DP1 = array:set(0, 0, DP),
    solve(Nums, 0, DP1, NumSlots).

solve([], _, DP, _) ->
    lists:max(array:sparse_to_orddict(DP));
solve([Num | Nums], Mask, DP, NumSlots) ->
    NewDP = update_dp(Num, Mask, DP, NumSlots),
    solve(Nums, Mask, NewDP, NumSlots).

update_dp(Num, Mask, DP, NumSlots) ->
    lists:foldl(fun(Slot, AccDP) ->
        SlotMask = 3 bsl (2 * (Slot - 1)),
        Current = (Mask band SlotMask) bsr (2 * (Slot - 1)),
        if
            Current < 2 ->
                NewMask = Mask bor (1 bsl (2 * (Slot - 1))),
                CurrentVal = array:get(Mask, AccDP),
                NewVal = CurrentVal + (Num band Slot),
                case array:get(NewMask, AccDP) of
                    -1 -> array:set(NewMask, NewVal, AccDP);
                    ExistingVal when NewVal > ExistingVal -> array:set(NewMask, NewVal, AccDP);
                    _ -> AccDP
                end;
            true -> AccDP
        end
    end, DP, lists:seq(1, NumSlots)).