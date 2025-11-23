-module(solution).
-export([strongPasswordChecker/1]).

strongPasswordChecker(S) ->
    N = length(S),

    % 1. Calculate missing character types
    MissingTypes =
        (if lists:any(fun(C) -> C >= $a andalso C =< $z end, S) -> 0; true -> 1 end) +
        (if lists:any(fun(C) -> C >= $A andalso C =< $Z end, S) -> 0; true -> 1 end) +
        (if lists:any(fun(C) -> C >= $0 andalso C =< $9 end, S) -> 0; true -> 1 end),

    % 2. Find repeating blocks and calculate total replacements needed
    RepeatingBlocks = find_repeating_blocks(S),
    TotalReplacementsNeeded = lists:sum(lists:map(fun(K) -> K div 3 end, RepeatingBlocks)),

    if N < 6 ->
        NeededInsertions = 6 - N,
        ChangesForMissing = max(0, MissingTypes - NeededInsertions),
        ChangesForRepeating = max(0, TotalReplacementsNeeded - NeededInsertions),
        NeededInsertions + max(ChangesForMissing, ChangesForRepeating);
    true -> % N >= 6
        if N > 20 ->
            OverLength = N - 20,
            Ans = OverLength, % These are mandatory deletions

            DeletionsAvailable = OverLength,

            Mod0Blocks = [], % list of K for K rem 3 == 0
            Mod1Blocks = [], % list of K for K rem 3 == 1
            Mod2Blocks = [], % list of K for K rem 3 == 2

            {FinalMod0Blocks, FinalMod1Blocks, FinalMod2Blocks} =
                lists:foldl(fun(K, {M0, M1, M2}) ->
                    case K rem 3 of
                        0 -> {[K | M0], M1, M2};
                        1 -> {M0, [K | M1], M2};
                        2 -> {M0, M1, [K | M2]}
                    end
                end, {Mod0Blocks, Mod1Blocks, Mod2Blocks}, RepeatingBlocks),

            % Phase 1: Delete from K rem 3 == 0 blocks. Each deletion saves 1 replacement.
            % Sort by K to prioritize deleting from smaller blocks first.
            {CurrentReplacementsNeeded, CurrentDeletionsAvailable} =
                lists:foldl(fun(K, {RepNeeded, DelAvail}) ->
                    if DelAvail == 0 -> {RepNeeded, DelAvail};
                    true ->
                        CanDelete = min(DelAvail, K div 3),
                        {RepNeeded - CanDelete, DelAvail - CanDelete}
                    end
                end, {TotalReplacementsNeeded, DeletionsAvailable}, lists:sort(FinalMod0Blocks)),

            % Phase 2: Delete from K rem 3 == 1 blocks. Each deletion saves 1 replacement, but costs 2 deletions.
            {CurrentReplacementsNeeded2, CurrentDeletionsAvailable2} =
                lists:foldl(fun(K, {RepNeeded, DelAvail}) ->
                    if DelAvail < 2 -> {RepNeeded, DelAvail};
                    true ->
                        CanDelete = min(DelAvail div 2, K div 3),
                        {RepNeeded - CanDelete, DelAvail - CanDelete * 2}
                    end
                end, {CurrentReplacementsNeeded, CurrentDeletionsAvailable}, lists:sort(FinalMod1Blocks)),

            % Phase 3: Any remaining deletions reduce replacements needed by 1 for every 3 deletions.
            FinalReplacementsNeeded = CurrentReplacementsNeeded2 - (CurrentDeletionsAvailable2 div 3),

            Ans + max(MissingTypes, max(0, FinalReplacementsNeeded));
        true -> % 6 <= N <= 20
            max(MissingTypes, TotalReplacementsNeeded)
        end
    end.

find_repeating_blocks(S) ->
    find_repeating_blocks_impl(S, [], -1, 0).

find_repeating_blocks_impl([], Acc, _PrevChar, Count) ->
    if Count >= 3 -> [Count | Acc]; true -> Acc end;
find_repeating_blocks_impl([Char | Rest], Acc, PrevChar, Count) ->
    if Char == PrevChar ->
        find_repeating_blocks_impl(Rest, Acc, PrevChar, Count + 1);
    true ->
        NewAcc = if Count >= 3 -> [Count | Acc]; true -> Acc end,
        find_repeating_blocks_impl(Rest, NewAcc, Char, 1)
    end.