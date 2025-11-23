-module(solution).
-export([longestPath/2]).

longestPath(Parent, S) ->
    N = length(S),

    Parent_array = array:from_list(Parent),
    Adj = build_adj_list(Parent_array, N),

    S_array = array:from_list(S),

    MaxPathRef = ets:new(max_path_table, [set, protected, {read_concurrency, true}]),
    ets:insert(MaxPathRef, {max_val, 1}), 

    dfs(0, -1, Adj, S_array, MaxPathRef),

    [{max_val, Result}] = ets:lookup(MaxPathRef, max_val),
    ets:delete(MaxPathRef), 
    Result.

build_adj_list(Parent_array, N) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(
        fun(I, CurrentAdj) ->
            P_idx = array:get(I, Parent_array), 
            array:set(P_idx, [I | array:get(P_idx, CurrentAdj)], CurrentAdj)
        end,
        Adj,
        lists:seq(1, N - 1)
    ).

dfs(U, _ParentU, Adj, S_array, MaxPathRef) ->
    Children = array:get(U, Adj),

    LongestPath1 = 0,
    LongestPath2 = 0,

    CharU = array:get(U, S_array), 

    {FinalLongestPath1, FinalLongestPath2} = lists:foldl(
        fun(V, {CurrentLongest1, CurrentLongest2}) ->
            PathDownV = dfs(V, U, Adj, S_array, MaxPathRef),

            CharV = array:get(V, S_array), 

            if CharU =/= CharV ->
                NewPathLength = PathDownV + 1,
                if NewPathLength > CurrentLongest1 ->
                    {NewPathLength, CurrentLongest1};
                NewPathLength > CurrentLongest2 ->
                    {CurrentLongest1, NewPathLength};
                true ->
                    {CurrentLongest1, CurrentLongest2}
                end;
            true ->
                {CurrentLongest1, CurrentLongest2}
            end
        end,
        {LongestPath1, LongestPath2}, 
        Children
    ),

    CurrentMax = element(2, ets:lookup(MaxPathRef, max_val)),
    ets:update_element(MaxPathRef, max_val, {2, max(CurrentMax, FinalLongestPath1 + FinalLongestPath2 + 1)}),

    FinalLongestPath1.