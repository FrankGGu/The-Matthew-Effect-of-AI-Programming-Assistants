-module(solution).
-export([smallestEquivalentString/3]).

replace_at(List, Index, Value) ->
    lists:sublist(List, 1, Index - 1) ++ [Value] ++ lists:sublist(List, Index + 1, length(List) - Index).

init_parents() ->
    lists:seq(0, 25).

find(Parents, I) ->
    PI = lists:nth(I + 1, Parents),
    if PI == I ->
        {Parents, I};
    true ->
        {NewParents_recursive, Root} = find(Parents, PI),
        UpdatedParents = replace_at(NewParents_recursive, I + 1, Root),
        {UpdatedParents, Root}
    end.

union(Parents, I, J) ->
    {Parents1, RootI} = find(Parents, I),
    {Parents2, RootJ} = find(Parents1, J),
    if RootI == RootJ ->
        Parents2;
    true ->
        MinRoot = min(RootI, RootJ),
        MaxRoot = max(RootI, RootJ),
        replace_at(Parents2, MaxRoot + 1, MinRoot)
    end.

smallestEquivalentString(S1, S2, BaseStr) ->
    S1_codes = S1,
    S2_codes = S2,
    BaseStr_codes = BaseStr,

    InitialParents = init_parents(),

    FinalParents = lists:foldl(
        fun({Char1, Char2}, CurrentParents) ->
            Idx1 = Char1 - $a,
            Idx2 = Char2 - $a,
            union(CurrentParents, Idx1, Idx2)
        end,
        InitialParents,
        lists:zip(S1_codes, S2_codes)
    ),

    ResultCodes = lists:map(
        fun(Char) ->
            Idx = Char - $a,
            {_NotUsedParents, RootIdx} = find(FinalParents, Idx),
            RootIdx + $a
        end,
        BaseStr_codes
    ),

    ResultCodes.