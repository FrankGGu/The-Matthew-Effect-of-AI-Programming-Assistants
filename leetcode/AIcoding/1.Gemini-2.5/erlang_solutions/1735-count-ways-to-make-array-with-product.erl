-module(solution).
-export([countWays/3]).

-define(MOD, 1000000007).

-persistent_term:put(fact, []).
-persistent_term:put(inv_fact, []).

init_combinations(MaxN) ->
    Fact = array:new([{size, MaxN + 1}, {fixed, true}]),
    InvFact = array:new([{size, MaxN + 1}, {fixed, true}]),
    Fact1 = array:set(0, 1, Fact),
    InvFact1 = array:set(0, 1, InvFact),
    {FinalFact, FinalInvFact} = init_combinations_loop(1, MaxN, Fact1, InvFact1),
    -persistent_term:put(fact, FinalFact),
    -persistent_term:put(inv_fact, FinalInvFact).

init_combinations_loop(I, MaxN, FactAcc, InvFactAcc) when I =< MaxN ->
    FactI = (array:get(I - 1, FactAcc) * I) rem ?MOD,
    InvFactI = mod_inverse(FactI, ?MOD),
    FactAcc1 = array:set(I, FactI, FactAcc),
    InvFactAcc1 = array:set(I, InvFactI, InvFactAcc),
    init_combinations_loop(I + 1, MaxN, FactAcc1, InvFactAcc1);
init_combinations_loop(_, _, FactAcc, InvFactAcc) ->
    {FactAcc, InvFactAcc}.

nCr(N, R) when R < 0; R > N -> 0;
nCr(N, R) ->
    Fact = -persistent_term:get(fact),
    InvFact = -persistent_term:get(inv_fact),
    (array:get(N, Fact) * array:get(R, InvFact) rem ?MOD * array:get(N - R, InvFact)) rem ?MOD.

mod_inverse(N, M) ->
    mod_pow(N, M - 2, M).

mod_pow(_, 0, _) -> 1;
mod_pow(Base, Exp, Mod) ->
    mod_pow_loop(Base, Exp, Mod, 1).

mod_pow_loop(_, 0, _, Acc) -> Acc;
mod_pow_loop(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod; true -> Acc end,
    NewBase = (Base * Base) rem Mod,
    mod_pow_loop(NewBase, Exp div 2, Mod, NewAcc).

get_prime_factors(N) ->
    get_prime_factors_loop(N, 2, []).

get_prime_factors_loop(1, _, Acc) -> lists:reverse(Acc);
get_prime_factors_loop(N, D, Acc) when D * D =< N ->
    case N rem D of
        0 ->
            Count = count_factors(N, D, 0),
            get_prime_factors_loop(N div (band_pow(D, Count)), D + 1, [{D, Count} | Acc]);
        _ ->
            get_prime_factors_loop(N, D + 1, Acc)
    end;
get_prime_factors_loop(N, _, Acc) ->
    lists:reverse([{N, 1} | Acc]).

count_factors(N, D, Count) when N rem D == 0 ->
    count_factors(N div D, D, Count + 1);
count_factors(_, _, Count) -> Count.

band_pow(Base, Exp) -> band_pow_loop(Base, Exp, 1).
band_pow_loop(_, 0, Acc) -> Acc;
band_pow_loop(Base, Exp, Acc) -> band_pow_loop(Base, Exp - 1, Acc * Base).

countWays(Nums, K, P) ->
    init_combinations(length(Nums)),

    %% Handle P = 0 case
    ZerosCount = lists:foldl(fun(X, Acc) -> if X == 0 -> Acc + 1; true -> Acc end end, 0, Nums),
    if P == 0 ->
        if ZerosCount == 0 -> 0;
           K == 0 -> 0; % Cannot form product 0 with 0 elements
           true -> nCr(length(Nums) - 1, K - 1)
        end;
       true ->
        countWays_non_zero_P(Nums, K, P, ZerosCount)
    end.

countWays_non_zero_P(Nums, K, P, ZerosCount) ->
    FilteredNums = lists:filter(fun(X) -> X /= 0 end, Nums),

    P_abs = abs(P),
    P_sign_parity = if P < 0 -> 1; true -> 0 end, % 0 for positive, 1 for negative

    P_factors_list = get_prime_factors(P_abs),
    P_factors_map = maps:from_list(P_factors_list),

    %% Map factor tuples to indices
    FactorTuples = get_all_factor_tuples(P_factors_map),
    FactorTupleToIndex = maps:from_list(lists:zip(FactorTuples, lists:seq(0, length(FactorTuples) - 1))),
    IndexToFactorTuple = maps:from_list(lists:zip(lists:seq(0, length(FactorTuples) - 1), FactorTuples)),

    %% Base factor tuple for 1 (empty product)
    BaseFactorTupleIdx = maps:get(maps:new(), FactorTupleToIndex),

    %% DP table: dp[k_count][{factor_tuple_idx, neg_parity}] -> count
    DP = lists:duplicate(K + 1, maps:new()),

    InitialDP_map = maps:put({BaseFactorTupleIdx, 0}, 1, maps:new()), % dp[0][BaseFactorTupleIdx][0] = 1
    DP1 = lists:replace_nth(1, InitialDP_map, DP), % Index 0 is for K_count=0

    %% Process numbers, excluding 1 and -1
    OnesCount = lists:foldl(fun(X, Acc) -> if X == 1 -> Acc + 1; true -> Acc end end, 0, FilteredNums),
    NegOnesCount = lists:foldl(fun(X, Acc) -> if X == -1 -> Acc + 1; true -> Acc end end, 0, FilteredNums),

    NumsToProcess = lists:filter(fun(X) -> X /= 1 andalso X /= -1 end, FilteredNums),

    FinalDP = lists:foldl(fun(Num, CurrentDP) ->
        AbsNum = abs(Num),
        SignNum = if Num < 0 -> 1; true -> 0 end, % 0 for positive, 1 for negative

        case get_num_factor_tuple(AbsNum, P_factors_map) of
            {ok, NumFactorTuple} ->
                case maps:find(NumFactorTuple, FactorTupleToIndex) of
                    {ok, NumFactorTupleIdx} ->
                        update_dp_01_knapsack(NumFactorTupleIdx, SignNum, K, IndexToFactorTuple, FactorTupleToIndex, P_factors_map, CurrentDP);
                    error -> CurrentDP % Should not happen if get_num_factor_tuple returned ok
                end;
            error -> CurrentDP % Num is not a valid factor of P_abs
        end
    end, DP1, NumsToProcess),

    TotalWays = calculate_final_ways(K, P_sign_parity, FinalDP, IndexToFactorTuple, FactorTupleToIndex, P_factors_map, BaseFactorTupleIdx, OnesCount, NegOnesCount),
    TotalWays.

calculate_final_ways(K, P_sign_parity, FinalDP, IndexToFactorTuple, FactorTupleToIndex, P_factors_map, BaseFactorTupleIdx, OnesCount, NegOnesCount) ->
    TargetFactorTupleIdx = maps:get(P_factors_map, FactorTupleToIndex),

    lists:foldl(fun(K_prime, Acc) ->
        DP_K_prime = lists:nth(K_prime + 1, FinalDP),
        maps:fold(fun({FT_idx, NP_prime}, Count, CurrentAcc) ->
            if FT_idx == TargetFactorTupleIdx ->
                RemK = K - K_prime,
                if RemK < 0 -> CurrentAcc;
                   true ->
                    NeededNPFromOnesNegOnes = (P_sign_parity - NP_prime + 2) rem 2,
                    WaysFromOnesNegOnes = count_ways_from_ones_neg_ones(RemK, NeededNPFromOnesNegOnes, OnesCount, NegOnesCount),
                    (CurrentAcc + Count * WaysFromOnesNegOnes) rem ?MOD
                end;
               true -> CurrentAcc
            end
        end, Acc, DP_K_prime)
    end, 0, lists:seq(0, K)).

count_ways_from_ones_neg_ones(RemK, NeededNP, OnesCount, NegOnesCount) ->
    lists:foldl(fun(L, Acc) ->
        J = RemK - L,
        if J >= 0 andalso J =< OnesCount andalso L =< NegOnesCount andalso L rem 2 == NeededNP ->
            (Acc + nCr(OnesCount, J) * nCr(NegOnesCount, L)) rem ?MOD;
           true -> Acc
        end
    end, 0, lists:seq(0, RemK)).

update_dp_01_knapsack(NumFactorTupleIdx, SignNum, K, IndexToFactorTuple, FactorTupleToIndex, TargetPFactorsMap, CurrentDP) ->
    NewDP = lists:duplicate(K + 1, maps:new()),
    lists:foldl(fun(K_idx, AccDP) ->
        lists:replace_nth(K_idx + 1, lists:nth(K_idx + 1, CurrentDP), AccDP)
    end, NewDP, lists:seq(0, K)),

    lists:foldl(fun(K_idx, AccDP) ->
        DP_K_idx_minus_1_Map = lists:nth(K_idx, CurrentDP), % This is dp[K_idx-1] from previous item
        Current_DP_K_idx_Map = lists:nth(K_idx + 1, AccDP), % This is dp[K_idx] for current item (already copied from previous item's dp[K_idx])

        Updated_DP_K_idx_Map = maps:fold(fun({PrevFT_idx, PrevNP}, Count, AccMap) ->
            PrevFT = maps:get(PrevFT_idx, IndexToFactorTuple),
            NumFT = maps:get(NumFactorTupleIdx, FactorTupleToIndex),

            CombinedFT = combine_factor_tuples_maps(PrevFT, NumFT),

            case is_valid_factor_tuple(CombinedFT, TargetPFactorsMap) of
                true ->
                    NewNP = (PrevNP + SignNum) rem 2,
                    NewFT_idx = maps:get(CombinedFT, FactorTupleToIndex),

                    maps:update_with({NewFT_idx, NewNP}, fun(V) -> (V + Count) rem ?MOD end, Count, AccMap);
                false -> AccMap
            end
        end, Current_DP_K_idx_Map, DP_K_idx_minus_1_Map),

        lists:replace_nth(K_idx + 1, Updated_DP_K_idx_Map, AccDP)
    end, NewDP, lists:seq(K, 1, -1)).

get_all_factor_tuples(P_factors_map) ->
    P_factors_list = maps:to_list(P_factors_map),
    generate_factor_tuples(P_factors_list, maps:new(), [maps:new()]).

generate_factor_tuples([], _, Acc) -> Acc;
generate_factor_tuples([{P_prime, P_exp} | Rest], CurrentTuple, Acc) ->
    lists:foldl(fun(Exp, CurrentAcc) ->
        NewTuple = maps:put(P_prime, Exp, CurrentTuple),
        generate_factor_tuples(Rest, NewTuple, [NewTuple | CurrentAcc])
    end, Acc, lists:seq(0, P_exp)).

get_num_factor_tuple(AbsNum, P_factors_map) ->
    NumFactors = get_prime_factors(AbsNum),
    NumFactorTuple = maps:new(),
    case lists:foldl(fun({Prime, Exp}, {ok, AccMap}) ->
        case maps:find(Prime, P_factors_map) of
            {ok, P_max_exp} ->
                if Exp =< P_max_exp ->
                    {ok, maps:put(Prime, Exp, AccMap)};
                   true -> error
                end;
            error -> error % Prime factor not in P_abs
        end
    end, {ok, NumFactorTuple}, NumFactors) of
        {ok, FinalNumFactorTuple} -> {ok, FinalNumFactorTuple};
        error -> error
    end.

combine_factor_tuples_maps(FT1, FT2) ->
    maps:fold(fun(Prime, Exp1, AccMap) ->
        Exp2 = maps:get(Prime, FT2, 0),
        maps:put(Prime, Exp1 + Exp2, AccMap)
    end, FT1, FT2).

is_valid_factor_tuple(CombinedFT, TargetPFactorsMap) ->
    maps:fold(fun(Prime, Exp, Acc) ->
        if Acc == false -> false;
           true ->
            P_max_exp = maps:get(Prime, TargetPFactorsMap, 0),
            Exp =< P_max_exp
        end
    end, true, CombinedFT).