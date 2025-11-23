-module(solution).
-export([distance_limited_paths_exist/3]).

init_uf(N) ->
    ParentArray = array:from_list(lists:seq(0, N-1)),
    RankArray = array:new(N, {default, 0}),
    {ParentArray, RankArray}.

find_uf({ParentArray, RankArray}, I) ->
    ParentI = array:get(I, ParentArray),
    if
        ParentI == I ->
            {{ParentArray, RankArray}, I};
        true ->
            {{NewParentArray, NewRankArray}, Root} = find_uf({ParentArray, RankArray}, ParentI),
            {{array:set(I, Root, NewParentArray), NewRankArray}, Root}
    end.

union_uf({ParentArray, RankArray}, I, J) ->
    {{ParentArray1, RankArray1}, RootI} = find_uf({ParentArray, RankArray}, I),
    {{ParentArray2, RankArray2}, RootJ} = find_uf({ParentArray1, RankArray1}, J),
    if
        RootI == RootJ ->
            {ParentArray2, RankArray2};
        true ->
            RankI = array:get(RootI, RankArray2),
            RankJ = array:get(RootJ, RankArray2),
            if
                RankI < RankJ ->
                    {array:set(RootI, RootJ, ParentArray2), RankArray2};
                RankJ < RankI ->
                    {array:set(RootJ, RootI, ParentArray2), RankArray2};
                true -> % Ranks are equal
                    ParentArray3 = array:set(RootJ, RootI, ParentArray2),
                    RankArray3 = array:set(RootI, RankI + 1, RankArray2),
                    {ParentArray3, RankArray3}
            end
    end.

distance_limited_paths_exist(N, EdgeList, Queries) ->
    SortedEdges = lists:sort(fun({W1, _, _}, {W2, _, _}) when W1 < W2 -> true; _ -> false end,
                             [ {W, U, V} || [U, V, W] <- EdgeList ]),

    IndexedQueries = lists:zip(Queries, lists:seq(0, length(Queries) - 1)),
    SortedQueries = lists:sort(fun({{_,_,L1},_}, {{_,_,L2},_}) when L1 < L2 -> true; _ -> false end,
                               IndexedQueries),

    InitialUF = init_uf(N),

    NumQueries = length(Queries),
    ResultArray = array:new(NumQueries, {default, false}),

    process_queries(SortedQueries, SortedEdges, InitialUF, ResultArray).

process_queries([], _CurrentEdgesTail, _UF, ResultArray) ->
    array:to_list(ResultArray);
process_queries([{Query, OriginalIdx} | RestQueries], CurrentEdgesTail, CurrentUF, ResultArray) ->
    [U, V, Limit] = Query,

    {NextUF, RemainingEdges} = add_edges_until_limit(CurrentEdgesTail, CurrentUF, Limit),

    {{UFAfterFindU, RankAfterFindU}, RootU} = find_uf(NextUF, U),
    {{UFAfterFindV, RankAfterFindV}, RootV} = find_uf({UFAfterFindU, RankAfterFindU}, V),

    IsConnected = (RootU == RootV),

    UpdatedResultArray = array:set(OriginalIdx, IsConnected, ResultArray),

    process_queries(RestQueries, RemainingEdges, {UFAfterFindV, RankAfterFindV}, UpdatedResultArray).

add_edges_until_limit(EdgesList, CurrentUF, Limit) ->
    add_edges_until_limit_loop(EdgesList, CurrentUF, Limit).

add_edges_until_limit_loop([], UF, _Limit) ->
    {UF, []};
add_edges_until_limit_loop([{Weight, U, V} | RestEdges], CurrentUF, Limit) ->
    if
        Weight < Limit ->
            UpdatedUF = union_uf(CurrentUF, U, V),
            add_edges_until_limit_loop(RestEdges, UpdatedUF, Limit);
        true ->
            {CurrentUF, [{Weight, U, V} | RestEdges]}
    end.