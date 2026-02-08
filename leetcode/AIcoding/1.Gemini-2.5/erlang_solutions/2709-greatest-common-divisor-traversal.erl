-module(solution).
-export([gcd_traversal/1]).

init_dsu(N) ->
    {array:from_list(lists:seq(0, N - 1)), array:from_list(lists:duplicate(N, 0))}.

find(I, ParentArr) ->
    ParentI = array:get(I, ParentArr),
    if
        ParentI == I -> {I, ParentArr};
        true ->
            {Root, NewParentArr} = find(ParentI, ParentArr),
            {Root, array:set(I, Root, NewParentArr)}
    end.

union(I, J, ParentArr, RankArr) ->
    {RootI, ParentArr1} = find(I, ParentArr),
    {RootJ, ParentArr2} = find(J, ParentArr1),
    if
        RootI /= RootJ ->
            RankI = array:get(RootI, RankArr),
            RankJ = array:get(RootJ, RankArr),
            if
                RankI < RankJ ->
                    NewParentArr = array:set(RootI, RootJ, ParentArr2),
                    {NewParentArr, RankArr};
                RankJ < RankI ->
                    NewParentArr = array:set(RootJ, RootI, ParentArr2),
                    {NewParentArr, RankArr};
                true ->
                    NewParentArr = array:set(RootJ, RootI, ParentArr2),
                    NewRankArr = array:set(RootI, RankI + 1, RankArr),
                    {NewParentArr, NewRankArr}
            end;
        true ->
            {ParentArr2, RankArr}
    end.

sieve_spf(MaxVal) ->
    InitialSPF = array:from_list(lists:seq(0, MaxVal)),
    sieve_spf_loop(2, MaxVal, InitialSPF).

sieve_spf_loop(P, MaxVal, SPF) when P =< MaxVal ->
    CurrentSPF_P = array:get(P, SPF),
    UpdatedSPF = if CurrentSPF_P == P ->
                     mark_multiples_spf(P * P, P, MaxVal, SPF);
                 true -> SPF
                 end,
    sieve_spf_loop(P + 1, MaxVal, UpdatedSPF);
sieve_spf_loop(_P, _MaxVal, SPF) ->
    SPF.

mark_multiples_spf(J, P, MaxVal, SPF) when J =< MaxVal ->
    CurrentSPF_J = array:get(J, SPF),
    NewSPF = if CurrentSPF_J == J ->
                 array:set(J, P, SPF);
             true -> SPF
             end,
    mark_multiples_spf(J + P, P, MaxVal, NewSPF);
mark_multiples_spf(_J, _P, _MaxVal, SPF) ->
    SPF.

get_distinct_prime_factors_spf(N, SPF) ->
    get_distinct_prime_factors_spf(N, SPF, sets:new()).

get_distinct_prime_factors_spf(1, _SPF, AccSet) -> sets:to_list(AccSet);
get_distinct_prime_factors_spf(N, SPF, AccSet) ->
    P = array:get(N, SPF),
    get_distinct_prime_factors_spf(N div P, SPF, sets:add_element(P, AccSet)).

gcd_traversal(Nums) ->
    N = length(Nums),

    if N == 1 -> true; true -> ok end,

    case lists:member(1, Nums) of
        true -> false;
        false ->
            MaxVal = lists:max(Nums),
            SPF_Arr = sieve_spf(MaxVal),

            {ParentArr0, RankArr0} = init_dsu(N),
            PrimeToRoot0 = dict:new(),

            {FinalParentArr, FinalRankArr, _FinalPrimeToRoot} =
                lists:foldl(fun({Num, Idx}, {AccParentArr, AccRankArr, AccPrimeToRoot}) ->
                                PrimeFactors = get_distinct_prime_factors_spf(Num, SPF_Arr),
                                lists:foldl(fun(P, {CurrentParentArr, CurrentRankArr, CurrentPrimeToRoot}) ->
                                                case dict:find(P, CurrentPrimeToRoot) of
                                                    {ok, ExistingIdxForPrime} ->
                                                        {NewParentArr, NewRankArr} = union(Idx, ExistingIdxForPrime, CurrentParentArr, CurrentRankArr),
                                                        {NewParentArr, NewRankArr, CurrentPrimeToRoot};
                                                    _ ->
                                                        {RootIdx, UpdatedParentArr} = find(Idx, CurrentParentArr),
                                                        {UpdatedParentArr, CurrentRankArr, dict:store(P, RootIdx, CurrentPrimeToRoot)}
                                                end
                                            end, {AccParentArr, AccRankArr, AccPrimeToRoot}, PrimeFactors)
                            end, {ParentArr0, RankArr0, PrimeToRoot0}, lists:zip(Nums, lists:seq(0, N - 1))),

            Roots = sets:new(),
            lists:foldl(fun(Idx, AccRoots) ->
                            {Root, _} = find(Idx, FinalParentArr),
                            sets:add_element(Root, AccRoots)
                        end, Roots, lists:seq(0, N - 1)),

            sets:size(Roots) == 1
    end.