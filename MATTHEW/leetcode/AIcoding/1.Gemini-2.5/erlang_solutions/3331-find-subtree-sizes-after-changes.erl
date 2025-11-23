-module(solution).
-export([solve/4]).

-record(dfs_state, {current_time, start_times, end_times}).

bit_new(Size) ->
    array:new([{default, 0}, {size, Size + 1}]).

bit_update(BIT, Index, Value, MaxIndex) when Index =< MaxIndex ->
    CurrentValue = array:get(Index, BIT),
    NewBIT = array:set(Index, CurrentValue + Value, BIT),
    NextIndex = Index + (Index band -Index),
    bit_update(NewBIT, NextIndex, Value, MaxIndex);
bit_update(BIT, _, _, _) ->
    BIT.

bit_query(BIT, Index) when Index > 0 ->
    CurrentValue = array:get(Index, BIT),
    NextIndex = Index - (Index band -Index),
    CurrentValue + bit_query(BIT, NextIndex);
bit_query(_BIT, 0) ->
    0.

dfs_traverse(Node, Parent, Adj, #dfs_state{current_time = CT, start_times = ST, end_times = ET} = Acc) ->
    NewST = array:set(Node, CT, ST),
    NewAcc1 = Acc#dfs_state{current_time = CT + 1, start_times = NewST},

    Neighbors = array:get(Node, Adj),
    Children = [Child || Child <- Neighbors, Child =/= Parent],

    NewAcc2 = lists:foldl(fun(Child, CurrentAcc) ->
                                  dfs_traverse(Child, Node, Adj, CurrentAcc)
                          end, NewAcc1, Children),

    NewET = array:set(Node, NewAcc2#dfs_state.current_time, NewAcc2#dfs_state.end_times),
    NewAcc2#dfs_state{end_times = NewET}.

solve(N, Edges, InitialValues, Queries) ->
    Adj = build_adj(N, Edges),

    InitialDFSState = #dfs_state{
        current_time = 1,
        start_times = array:new([{default, 0}, {size, N + 1}]),
        end_times = array:new([{default, 0}, {size, N + 1}])
    },
    FinalDFSState = dfs_traverse(1, 0, Adj, InitialDFSState),
    StartTimes = FinalDFSState#dfs_state.start_times,
    EndTimes = FinalDFSState#dfs_state.end_times,
    MaxTime = FinalDFSState#dfs_state.current_time - 1,

    BIT = bit_new(MaxTime),
    CurrentNodeValues = array:from_list([0 | InitialValues]),

    InitialBITAndValues = lists:foldl(
        fun(Node, {CurrentBIT, CurrentValues}) ->
            Value = array:get(Node, CurrentValues),
            StartTime = array:get(Node, StartTimes),
            NewBIT = bit_update(CurrentBIT, StartTime, Value, MaxTime),
            {NewBIT, CurrentValues}
        end,
        {BIT, CurrentNodeValues},
        lists:seq(1, N)
    ),
    {InitialBIT, InitialCurrentNodeValues} = InitialBITAndValues,

    process_queries(Queries, InitialBIT, InitialCurrentNodeValues, StartTimes, EndTimes, MaxTime, []).

build_adj(N, Edges) ->
    Adj = array:new([{default, []}, {size, N + 1}]),
    lists:foldl(
        fun({U, V}, CurrentAdj) ->
            Adj1 = array:set(U, [V | array:get(U, CurrentAdj)], CurrentAdj),
            array:set(V, [U | array:get(V, Adj1)], Adj1)
        end,
        Adj, Edges
    ).

process_queries([], _BIT, _NodeValues, _ST, _ET, _MT, Acc) ->
    lists:reverse(Acc);
process_queries([{1, Node, NewValue} | RestQueries], BIT, NodeValues, ST, ET, MT, Acc) ->
    OldValue = array:get(Node, NodeValues),
    Diff = NewValue - OldValue,
    StartTime = array:get(Node, ST),
    NewBIT = bit_update(BIT, StartTime, Diff, MT),
    NewNodeValues = array:set(Node, NewValue, NodeValues),
    process_queries(RestQueries, NewBIT, NewNodeValues, ST, ET, MT, Acc);
process_queries([{2, Node} | RestQueries], BIT, NodeValues, ST, ET, MT, Acc) ->
    StartTime = array:get(Node, ST),
    EndTime = array:get(Node, ET) - 1,
    SubtreeSum = bit_query(BIT, EndTime) - bit_query(BIT, StartTime - 1),
    process_queries(RestQueries, BIT, NodeValues, ST, ET, MT, [SubtreeSum | Acc]).