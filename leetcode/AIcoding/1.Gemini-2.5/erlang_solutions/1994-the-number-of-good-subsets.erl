-module(solution).
-export([goodSubsets/1]).

-define(MOD, 1000000007).

power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) -> Acc;
power(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
               true -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    power(NewBase, Exp div 2, Mod, NewAcc).

precompute_num_info() ->
    PrimeToIdx = #{2 => 0, 3 => 1, 5 => 2, 7 => 3, 11 => 4, 13 => 5, 17 => 6, 19 => 7, 23 => 8, 29 => 9},
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29],
    lists:foldl(fun(N, Acc) ->
        {Mask, IsSF} = calculate_mask_and_sf(N, PrimeToIdx, Primes),
        maps:put(N, {Mask, IsSF}, Acc)
    end, #{}, lists:seq(2, 30)).

calculate_mask_and_sf(OriginalN, TempN, PrimeToIdx, Primes, CurrentMask, IsSF) ->
    case Primes of
        [] ->
            {CurrentMask, IsSF and (TempN == 1)};
        [P|RestPrimes] ->
            case TempN rem P of
                0 ->
                    NewMask = CurrentMask bor (1 bsl maps:get(P, PrimeToIdx)),
                    NewTempN = TempN div P,
                    case NewTempN rem P of
                        0 ->
                            {0, false};
                        _ ->
                            calculate_mask_and_sf(OriginalN, NewTempN, PrimeToIdx, RestPrimes, NewMask, IsSF)
                    end;
                _ ->
                    calculate_mask_and_sf(OriginalN, TempN, PrimeToIdx, RestPrimes, CurrentMask, IsSF)
            end
    end.

goodSubsets(Nums) ->
    NumInfo = precompute_num_info(),

    Counts = lists:foldl(fun(N, Acc) ->
        maps:update_with(N, fun(Val) -> Val + 1 end, 1, Acc)
    end, #{}, Nums),

    CountOfOne = maps:get(1, Counts, 0),

    DP = #{0 => 1},

    FinalDP = lists:foldl(fun(N, CurrentDP) ->
        case maps:get(N, NumInfo) of
            {CurrentNumMask, true} ->
                NumOccurrences = maps:get(N, Counts, 0),
                if NumOccurrences > 0 ->
                    lists:foldl(fun({ExistingMask, ExistingCount}, AccDP) ->
                        if (ExistingMask band CurrentNumMask) == 0 ->
                            CombinedMask = ExistingMask bor CurrentNumMask,
                            NewCount = (maps:get(CombinedMask, AccDP, 0) + ExistingCount * NumOccurrences) rem ?MOD,
                            maps:put(CombinedMask, NewCount, AccDP);
                        true ->
                            AccDP
                        end
                    end, CurrentDP, maps:to_list(CurrentDP));
                true ->
                    CurrentDP
                end;
            _ ->
                CurrentDP
        end
    end, DP, lists:seq(2, 30)),

    TotalGoodSubsetsProduct = lists:foldl(fun({Mask, Count}, Acc) ->
        if Mask > 0 -> (Acc + Count) rem ?MOD;
        true -> Acc
        end
    end, 0, maps:to_list(FinalDP)),

    PowerOfTwoOnes = power(2, CountOfOne, ?MOD),
    Result = (TotalGoodSubsetsProduct * PowerOfTwoOnes) rem ?MOD,
    (Result + (PowerOfTwoOnes - 1 + ?MOD)) rem ?MOD.