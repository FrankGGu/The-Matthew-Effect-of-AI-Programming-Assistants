-module(solution).
-export([largest_multiple_of_three/1]).

largest_multiple_of_three(Digits) ->
    Sum = lists:foldl(fun(D, Acc) -> D + Acc end, 0, Digits),

    Mod0 = lists:filter(fun(D) -> D rem 3 == 0 end, Digits),
    Mod1 = lists:sort(lists:filter(fun(D) -> D rem 3 == 1 end, Digits)), % Sorted ascending
    Mod2 = lists:sort(lists:filter(fun(D) -> D rem 3 == 2 end, Digits)), % Sorted ascending

    FinalDigits = 
        case Sum rem 3 of
            0 ->
                Digits;
            1 -> % Sum mod 3 == 1, need to remove digits whose sum is 1 mod 3
                if 
                    length(Mod1) >= 1 ->
                        % Option 1: Remove one smallest digit from Mod1
                        RemovedMod1 = tl(Mod1),
                        Mod0 ++ RemovedMod1 ++ Mod2;
                    length(Mod2) >= 2 ->
                        % Option 2: Remove two smallest digits from Mod2
                        RemovedMod2 = tl(tl(Mod2)),
                        Mod0 ++ Mod1 ++ RemovedMod2;
                    true -> % No valid removal possible
                        []
                end;
            2 -> % Sum mod 3 == 2, need to remove digits whose sum is 2 mod 3
                if 
                    length(Mod2) >= 1 ->
                        % Option 1: Remove one smallest digit from Mod2
                        RemovedMod2 = tl(Mod2),
                        Mod0 ++ Mod1 ++ RemovedMod2;
                    length(Mod1) >= 2 ->
                        % Option 2: Remove two smallest digits from Mod1
                        RemovedMod1 = tl(tl(Mod1)),
                        Mod0 ++ RemovedMod1 ++ Mod2;
                    true -> % No valid removal possible
                        []
                end
        end,

    case FinalDigits of
        [] -> 
            "";
        _ ->
            SortedDesc = lists:reverse(lists:sort(FinalDigits)),
            if 
                hd(SortedDesc) == 0 -> 
                    "0";
                true -> 
                    lists:flatten([integer_to_list(D) || D <- SortedDesc])
            end
    end.