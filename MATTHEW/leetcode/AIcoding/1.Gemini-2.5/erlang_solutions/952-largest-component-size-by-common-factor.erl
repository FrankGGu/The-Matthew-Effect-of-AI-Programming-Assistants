-module(solution).
-export([largest_component_size/1]).

-include_lib("stdlib/include/array.hrl").

find_and_compress(I, Parents) ->
    ParentI = array:get(I, Parents),
    if
        ParentI == I -> {I, Parents};
        true ->
            {Root, UpdatedParents} = find_and_compress(ParentI, Parents),
            {Root, array:set(I, Root, UpdatedParents)}
    end.

union(I, J, Parents, Sizes) ->
    {RootI, Parents1} = find_and_compress(I, Parents),
    {RootJ, Parents2} = find_and_compress(J, Parents1),

    if
        RootI == RootJ -> {Parents2, Sizes};
        true ->
            SizeI = array:get(RootI, Sizes),
            SizeJ = array:get(RootJ, Sizes),
            if
                SizeI < SizeJ ->
                    NewParents = array:set(RootI, RootJ, Parents2),
                    NewSizes = array:set(RootJ, SizeI + SizeJ, Sizes),
                    {NewParents, NewSizes};
                true ->
                    NewParents = array:set(RootJ, RootI, Parents2),
                    NewSizes = array:set(RootI, SizeI + SizeJ, Sizes),
                    {NewParents, NewSizes}
            end
    end.

sieve_spf(MaxVal) ->
    SPF0 = array:from_list(lists:seq(0, MaxVal)),

    lists:foldl(
        fun(I, CurrentSPF) ->
            if array:get(I, CurrentSPF) == I ->
                lists:foldl(
                    fun(J, InnerSPF) ->
                        if J > MaxVal -> InnerSPF; true ->
                            if array:get(J, InnerSPF) == J ->
                                array:set(J, I, InnerSPF);
                            true -> InnerSPF
                            end
                        end
                    end,
                    CurrentSPF,
                    lists:seq(I * I, MaxVal, I)
                );
            true -> CurrentSPF
            end
        end,
        SPF0,
        lists:seq(2, MaxVal)
    ).

factorize_and_union_recursive(CurrentNum, OriginalNum, Parents, Sizes, SPF) ->
    if CurrentNum == 1 ->
        {Parents, Sizes};
    true ->
        P = array:get(CurrentNum, SPF),
        {NewParents1, NewSizes1} = union(OriginalNum, P, Parents, Sizes),

        NextNum = divide_by_factor(CurrentNum, P),

        factorize_and_union_recursive(NextNum, OriginalNum, NewParents1, NewSizes1, SPF)
    end.

divide_by_factor(N, P) ->
    if N rem P == 0 -> divide_by_factor(N div P, P);
    true -> N
    end.

largest_component_size(A) ->
    if A == [] -> 0; true ->
        MaxVal = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, A),

        InitialParents = array:from_list(lists:seq(0, MaxVal)),
        InitialSizes = array:from_list(lists:duplicate(MaxVal + 1, 1)),

        SPF = sieve_spf(MaxVal),

        {ParentsAfterUnions, _SizesAfterUnions} = lists:foldl(
            fun(Num, {CurrentParents, CurrentSizes}) ->
                if Num == 1 ->
                    {CurrentParents, CurrentSizes};
                true ->
                    factorize_and_union_recursive(Num, Num, CurrentParents, CurrentSizes, SPF)
                end
            end,
            {InitialParents, InitialSizes},
            A
        ),

        {ComponentCounts, _FinalParentsForCounting} = lists:foldl(
            fun(Num, {AccMap, CurrentParentsForCounting}) ->
                {Root, NewParentsForCounting} = find_and_compress(Num, CurrentParentsForCounting),
                NewAccMap = maps:update_with(Root, fun(V) -> V + 1 end, 1, AccMap),
                {NewAccMap, NewParentsForCounting}
            end,
            {maps:new(), ParentsAfterUnions},
            A
        ),

        case maps:to_list(ComponentCounts) of
            [] -> 0;
            _ -> lists:max(maps:values(ComponentCounts))
        end
    end.