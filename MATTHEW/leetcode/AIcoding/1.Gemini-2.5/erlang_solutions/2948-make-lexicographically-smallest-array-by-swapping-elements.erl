-module(solution).
-export([makeSmallestArray/2]).

init_dsu_arr(N) ->
    Parents = array:from_list(lists:seq(0, N-1)),
    Ranks = array:from_list(lists:duplicate(N, 1)),
    {Parents, Ranks}.

find_dsu_arr(I, Parents) ->
    Parent = array:get(I, Parents),
    if
        Parent == I -> {I, Parents};
        true ->
            {Root, UpdatedParents} = find_dsu_arr(Parent, Parents),
            {Root, array:set(I, Root, UpdatedParents)}
    end.

union_dsu_arr(I, J, {Parents, Ranks}) ->
    {RootI, Parents1} = find_dsu_arr(I, Parents),
    {RootJ, Parents2} = find_dsu_arr(J, Parents1), %% Chain updates to Parents array

    if
        RootI == RootJ -> {Parents2, Ranks}; %% Already in the same set
        true ->
            RankI = array:get(RootI, Ranks),
            RankJ = array:get(RootJ, Ranks),
            if
                RankI < RankJ ->
                    NewParents = array:set(RootI, RootJ, Parents2),
                    {NewParents, Ranks};
                RankJ < RankI ->
                    NewParents = array:set(RootJ, RootI, Parents2),
                    {NewParents, Ranks};
                true -> %% Ranks are equal, make RootJ child of RootI and increment RootI's rank
                    NewParents = array:set(RootJ, RootI, Parents2),
                    NewRanks = array:set(RootI, RankI + 1, Ranks),
                    {NewParents, NewRanks}
            end
    end.

makeSmallestArray(Nums, Limit) ->
    N = length(Nums),

    %% Create a list of {Value, OriginalIndex} pairs and sort it by Value.
    IndexedNums = lists:zip(Nums, lists:seq(0, N-1)),
    SortedIndexedNumsList = lists:sort(fun({V1, _}, {V2, _}) -> V1 =< V2 end, IndexedNums),
    SortedIndexedNumsArray = array:from_list(SortedIndexedNumsList),

    %% Convert original Nums list to an array for O(1) access during grouping.
    NumsArray = array:from_list(Nums),

    %% Initialize DSU structures.
    {Parents0, Ranks0} = init_dsu_arr(N),

    %% Build connected components using DSU and a two-pointer (sliding window) approach
    %% on the sorted indexed numbers.
    {_FinalLeftPtr, {FinalParents, _FinalRanks}} = 
        connect_components_loop(SortedIndexedNumsArray, Limit, N, 0, 0, {Parents0, Ranks0}),

    %% Group elements (values and their original indices) by their root in the DSU.
    Grouped = group_by_root(NumsArray, FinalParents, N),

    %% Reconstruct the result array by sorting values and indices within each component.
    array:to_list(make_result_array(Grouped, N)).

connect_components_loop(SortedIndexedNumsArray, Limit, N, CurrentIdx, LeftPtr, DSUState) ->
    if
        CurrentIdx >= N -> {LeftPtr, DSUState};
        true ->
            {Val_i, OrigIdx_i} = array:get(CurrentIdx, SortedIndexedNumsArray),

            %% Move LeftPtr forward while elements at LeftPtr are too far from Val_i
            NewLeftPtr = 
                begin
                    L = LeftPtr,
                    WhileLoop = 
                        fun Loop(Ptr) ->
                            if
                                Ptr < CurrentIdx ->
                                    {Val_k, _} = array:get(Ptr, SortedIndexedNumsArray),
                                    if
                                        Val_i - Val_k > Limit -> Loop(Ptr + 1);
                                        true -> Ptr
                                    end;
                                true -> Ptr
                            end
                        end,
                    WhileLoop(L)
                end,

            %% If there are elements in the window (NewLeftPtr < CurrentIdx),
            %% union the current element with the leftmost element in the window.
            UpdatedDSUState = 
                if
                    NewLeftPtr < CurrentIdx ->
                        {_Val_left, OrigIdx_left} = array:get(NewLeftPtr, SortedIndexedNumsArray),
                        union_dsu_arr(OrigIdx_i, OrigIdx_left, DSUState);
                    true ->
                        DSUState
                end,

            connect_components_loop(SortedIndexedNumsArray, Limit, N, CurrentIdx + 1, NewLeftPtr, UpdatedDSUState)
    end.

group_by_root(NumsArray, Parents, N) ->
    lists:foldl(
        fun(Idx, Acc) ->
            Val = array:get(Idx, NumsArray),
            {Root, _IgnoredParents} = find_dsu_arr(Idx, Parents), %% Path compression updates are local and not propagated to `Parents` here.

            maps:update_with(Root,
                             fun({Vals, Idxs}) -> {lists:append(Vals, [Val]), lists:append(Idxs, [Idx])} end,
                             {[Val], [Idx]},
                             Acc)
        end,
        #{},
        lists:seq(0, N-1)
    ).

make_result_array(Grouped, N) ->
    Result = array:from_list(lists:duplicate(N, 0)), %% Initialize result array
    lists:foldl(
        fun({_Root, {Vals, Idxs}}, AccResult) ->
            SortedVals = lists:sort(fun(A, B) -> A =< B end, Vals),
            SortedIdxs = lists:sort(fun(A, B) -> A =< B end, Idxs),

            lists:foldl(
                fun({Val, Idx}, CurrentResult) ->
                    array:set(Idx, Val, CurrentResult)
                end,
                AccResult,
                lists:zip(SortedVals, SortedIdxs)
            )
        end,
        Result,
        maps:to_list(Grouped)
    ).