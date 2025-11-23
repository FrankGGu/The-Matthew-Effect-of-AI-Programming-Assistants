-module(solution).
-export([smallest_string_with_swaps/2]).

init_dsu(N) ->
    Parent = maps:from_list(lists:zip(lists:seq(0, N-1), lists:seq(0, N-1))),
    Rank = maps:from_list(lists:zip(lists:seq(0, N-1), lists:duplicate(N, 0))),
    {Parent, Rank}.

find(I, Parent) ->
    case maps:get(I, Parent) of
        I -> {I, Parent};
        P ->
            {Root, NewParent} = find(P, Parent),
            {Root, maps:put(I, Root, NewParent)}
    end.

union(I, J, Parent, Rank) ->
    {RootI, Parent1} = find(I, Parent),
    {RootJ, Parent2} = find(J, Parent1),
    case RootI == RootJ of
        true -> {Parent2, Rank};
        false ->
            RankI = maps:get(RootI, Rank),
            RankJ = maps:get(RootJ, Rank),
            if RankI < RankJ ->
                {maps:put(RootI, RootJ, Parent2), Rank};
            RankI > RankJ ->
                {maps:put(RootJ, RootI, Parent2), Rank};
            true ->
                {maps:put(RootJ, RootI, Parent2), maps:put(RootI, RankI + 1, Rank)}
            end
    end.

smallest_string_with_swaps(S, Pairs) ->
    N = length(S),
    {Parent0, Rank0} = init_dsu(N),

    {ParentF, _RankF} = lists:foldl(fun([I, J], {P, R}) -> union(I, J, P, R) end, {Parent0, Rank0}, Pairs),

    ComponentMap = lists:foldl(fun({Idx, Char}, Acc) ->
                                   {Root, _ParentUpdated} = find(Idx, ParentF),
                                   maps:update_with(Root, fun({Cs, Is}) -> {[Char | Cs], [Idx | Is]} end, {[Char], [Idx]}, Acc)
                               end, #{}, lists:zip(lists:seq(0, N-1), S)),

    ResultArray = array:new([{size, N}, {fixed, true}]),

    FinalResultArray = maps:fold(fun(_Root, {CharsList, IndicesList}, CurrentArr) ->
                                     SortedChars = lists:sort(CharsList),
                                     SortedIndices = lists:sort(IndicesList),
                                     lists:foldl(fun({Idx, Char}, Arr) -> array:set(Idx, Char, Arr) end, CurrentArr, lists:zip(SortedIndices, SortedChars))
                                 end, ResultArray, ComponentMap),

    array:to_list(FinalResultArray).