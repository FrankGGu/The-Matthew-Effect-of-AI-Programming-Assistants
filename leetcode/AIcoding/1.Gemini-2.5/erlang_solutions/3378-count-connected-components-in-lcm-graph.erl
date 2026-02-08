-module(solution).
-export([count_connected_components_in_lcm_graph/1]).

init_dsu(N) ->
    ParentArray = gb_array:new(N, {default, 0}),
    ParentArray1 = lists:foldl(fun(I, Arr) -> gb_array:set(I, I, Arr) end, ParentArray, lists:seq(0, N-1)),
    {ParentArray1, N}.

find(I, ParentArray) ->
    ParentI = gb_array:get(I, ParentArray),
    if
        ParentI == I -> {I, ParentArray};
        true ->
            {Root, NewParentArray} = find(ParentI, ParentArray),
            {Root, gb_array:set(I, Root, NewParentArray)}
    end.

union(I, J, ParentArray, NumComponents) ->
    {RootI, PA1} = find(I, ParentArray),
    {RootJ, PA2} = find(J, PA1),
    if
        RootI /= RootJ ->
            {{gb_array:set(RootJ, RootI, PA2), NumComponents - 1}, true};
        true ->
            {{PA2, NumComponents}, false}
    end.

prime_factorization(N) ->
    prime_factorization_recursive(N, 2, []).

prime_factorization_recursive(1, _, Acc) ->
    lists:reverse(Acc);
prime_factorization_recursive(N, D, Acc) when D * D > N ->
    lists:reverse([N | Acc]);
prime_factorization_recursive(N, D, Acc) ->
    if
        N rem D == 0 ->
            prime_factorization_recursive(N div D, D, [D | Acc]);
        true ->
            prime_factorization_recursive(N, D + 1, Acc)
    end.

count_connected_components_in_lcm_graph(Nums) ->
    N = length(Nums),
    NumsArray = array:from_list(Nums),

    {ParentArray, NumComponents} = init_dsu(N),
    PrimeFactorMap = #{},

    {_FinalParentArray, FinalNumComponents, _FinalPrimeFactorMap} = lists:foldl(
        fun(I, {CurrentParentArray, CurrentNumComponents, CurrentPrimeFactorMap}) ->
            X = array:get(I, NumsArray),
            Factors = prime_factorization(X),

            lists:foldl(
                fun(P, {InnerParentArray, InnerNumComponents, InnerPrimeFactorMap}) ->
                    case maps:find(P, InnerPrimeFactorMap) of
                        {ok, FirstIdx} ->
                            {{NewParentArray, NewNumComponents}, _Merged} = union(I, FirstIdx, InnerParentArray, InnerNumComponents),
                            {NewParentArray, NewNumComponents, InnerPrimeFactorMap};
                        error ->
                            NewPrimeFactorMap = maps:put(P, I, InnerPrimeFactorMap),
                            {InnerParentArray, InnerNumComponents, NewPrimeFactorMap}
                    end
                end,
                {CurrentParentArray, CurrentNumComponents, CurrentPrimeFactorMap},
                Factors
            )
        end,
        {ParentArray, NumComponents, PrimeFactorMap},
        lists:seq(0, N - 1)
    ),
    FinalNumComponents.