-module(solution).
-export([matrixRankTransform/1]).

-record(s_dsu_state, {parents :: array:array(), ranks :: array:array()}).

s_dsu_new(Size) ->
    Parents = array:from_list(lists:seq(0, Size - 1)),
    Ranks = array:new(Size, 0),
    #s_dsu_state{parents = Parents, ranks = Ranks}.

s_dsu_find(DSU, I) ->
    Parents = DSU#s_dsu_state.parents,
    ParentI = array:get(I, Parents),
    if
        ParentI == I -> {I, DSU};
        true ->
            {Root, NewDSU} = s_dsu_find(DSU, ParentI),
            NewParents = array:set(I, Root, NewDSU#s_dsu_state.parents),
            {Root, NewDSU#s_dsu_state{parents = NewParents}}
    end.

s_dsu_union(DSU, I, J) ->
    {RootI, DSU1} = s_dsu_find(DSU, I),
    {RootJ, DSU2} = s_dsu_find(DSU1, J),

    if
        RootI == RootJ -> DSU2;
        true ->
            Parents = DSU2#s_dsu_state.parents,
            Ranks = DSU2#s_dsu_state.ranks,
            RankI = array:get(RootI, Ranks),
            RankJ = array:get(RootJ, Ranks),
            if
                RankI < RankJ ->
                    NewParents = array:set(RootI, RootJ, Parents),
                    DSU2#s_dsu_state{parents = NewParents};
                RankJ < RankI ->
                    NewParents = array:set(RootJ, RootI, Parents),
                    DSU2#s_dsu_state{parents = NewParents};
                true ->
                    NewParents = array:set(RootJ, RootI, Parents),
                    NewRanks = array:set(RootI, RankI + 1, Ranks),
                    DSU2#s_dsu_state{parents = NewParents, ranks = NewRanks}
            end
    end.

matrixRankTransform(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),

    ResultMatrix = array:new({M, N}, 0),
    RowMaxRank = array:new(M, 0),
    ColMaxRank = array:new(N, 0),

    Elements = extract_elements(Matrix, M, N),
    SortedElements = lists:sort(fun(A, B) -> A# {value} < B# {value} end, Elements),

    process_groups(SortedElements, ResultMatrix, RowMaxRank, ColMaxRank, M, N).

extract_elements(Matrix, M, N) ->
    extract_elements_rows(Matrix, 0, M, N, []).

extract_elements_rows([], _R, _M, _N, Acc) -> Acc;
extract_elements_rows([Row|RestRows], R, M, N, Acc) ->
    ElementsInRow = extract_elements_cols(Row, R, 0, N, []),
    extract_elements_rows(RestRows, R + 1, M, N, lists:append(ElementsInRow, Acc)).

extract_elements_cols([], _R, _C, _N, Acc) -> Acc;
extract_elements_cols([Val|RestVals], R, C, N, Acc) ->
    extract_elements_cols(RestVals, R, C + 1, N, [# {value => Val, row => R, col => C} | Acc]).

process_groups([], ResultMatrix, _RowMaxRank, _ColMaxRank, _M, _N) ->
    array_to_list_of_lists(ResultMatrix);
process_groups(SortedElements, ResultMatrix, RowMaxRank, ColMaxRank, M, N) ->
    {CurrentGroup, RestElements} = get_current_group(SortedElements),

    NumElementsInGroup = length(CurrentGroup),
    DSU = s_dsu_new(NumElementsInGroup),

    GroupWithIndices = lists:zip(lists:seq(0, NumElementsInGroup - 1), CurrentGroup),

    InitialFoldState = {DSU, array:new(NumElementsInGroup, 0), maps:new(), maps:new()},

    {_DSUBeforeUnions, FinalPotentialRanks, RowConnections, ColConnections} = lists:foldl(
        fun({Idx, Elem}, {AccDSU, AccPotentialRanks, AccRowConnections, AccColConnections}) ->
            R = Elem# {row},
            C = Elem# {col},

            PotentialRank = 1 + max(array:get(R, RowMaxRank), array:get(C, ColMaxRank)),
            NewPotentialRanks = array:set(Idx, PotentialRank, AccPotentialRanks),

            NewRowConnections = maps:update_with(R, fun(L) -> [Idx | L] end, [Idx], AccRowConnections),
            NewColConnections = maps:update_with(C, fun(L) -> [Idx | L] end, [Idx], AccColConnections),

            {AccDSU, NewPotentialRanks, NewRowConnections, NewColConnections}
        end, InitialFoldState, GroupWithIndices),

    DSUAfterRowUnions = maps:fold(
        fun(_R, Idxs, AccDSU) ->
            case Idxs of
                [] -> AccDSU;
                [H|T] -> lists:foldl(fun(Idx, TempDSU) -> s_dsu_union(TempDSU, H, Idx) end, AccDSU, T)
            end
        end, DSU, RowConnections),

    FinalDSUWithUnions = maps:fold(
        fun(_C, Idxs, AccDSU) ->
            case Idxs of
                [] -> AccDSU;
                [H|T] -> lists:foldl(fun(Idx, TempDSU) -> s_dsu_union(TempDSU, H, Idx) end, AccDSU, T)
            end
        end, DSUAfterRowUnions, ColConnections),

    ComponentMaxRanks = lists:foldl(fun({Idx, _Elem}, AccComponentMaxRanks) ->
        {Root, _IgnoredDSU} = s_dsu_find(FinalDSUWithUnions, Idx),
        Rank = array:get(Idx, FinalPotentialRanks),
        maps:update_with(Root, fun(OldMax) -> max(OldMax, Rank) end, Rank, AccComponentMaxRanks)
    end, maps:new(), GroupWithIndices),

    {NewResultMatrix, NewRowMaxRank, NewColMaxRank} = lists:foldl(
        fun({Idx, Elem}, {AccResultMatrix, AccRowMaxRank, AccColMaxRank}) ->
            {Root, _IgnoredDSU} = s_dsu_find(FinalDSUWithUnions, Idx),
            FinalRank = maps:get(Root, ComponentMaxRanks),
            R = Elem# {row},
            C = Elem# {col},

            UpdatedResultMatrix = array:set({R, C}, FinalRank, AccResultMatrix),
            UpdatedRowMaxRank = array:set(R, max(array:get(R, AccRowMaxRank), FinalRank), AccRowMaxRank),
            UpdatedColMaxRank = array:set(C, max(array:get(C, AccColMaxRank), FinalRank), AccColMaxRank),
            {UpdatedResultMatrix, UpdatedRowMaxRank, UpdatedColMaxRank}
        end, {ResultMatrix, RowMaxRank, ColMaxRank}, GroupWithIndices),

    process_groups(RestElements, NewResultMatrix, NewRowMaxRank, NewColMaxRank, M, N).

get_current_group([H|T]) ->
    Value = H# {value},
    get_current_group_acc(Value, [H], T).

get_current_group_acc(_Value, Acc, []) ->
    {lists:reverse(Acc), []};
get_current_group_acc(Value, Acc, [H|T]) ->
    if
        H# {value} == Value ->
            get_current_group_acc(Value, [H|Acc], T);
        true ->
            {lists:reverse(Acc), [H|T]}
    end.

array_to_list_of_lists(Array) ->
    {{0, MaxR}, {0, MaxC}} = array:size(Array),
    lists:map(fun(R) ->
        lists:map(fun(C) ->
            array:get({R, C}, Array)
        end, lists:seq(0, MaxC))
    end, lists:seq(0, MaxR)).