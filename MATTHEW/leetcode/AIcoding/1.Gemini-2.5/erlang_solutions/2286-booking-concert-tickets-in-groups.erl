-module(book_my_show).
-export([new/2, gather/3, scatter/3]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2, code_change/3]).

-record(node, {max_s :: integer(), sum_s :: integer(), lazy :: boolean()}).
-record(state, {n :: integer(), m :: integer(), next_row :: integer(), tree :: array:array(#node{})}).

new(N, M) ->
    gen_server:start_link(?MODULE, [N, M], []).

gather(Pid, K, MaxRow) ->
    gen_server:call(Pid, {gather, K, MaxRow}).

scatter(Pid, K, MaxRow) ->
    gen_server:call(Pid, {scatter, K, MaxRow}).

init([N, M]) ->
    TreeSize = 4 * N,
    Tree = array:new([{size, TreeSize + 1}, {fixed, true}, {default, #node{max_s=0, sum_s=0, lazy=false}}]),
    NewTree = build_tree(1, 0, N-1, M, Tree),
    {ok, #state{n=N, m=M, next_row=0, tree=NewTree}}.

handle_call({gather, K, MaxRow}, _From, State) ->
    #state{n=N, m=M, next_row=NextRow, tree=Tree} = State,
    ResultRow = query_find_first_available_row(1, 0, N-1, NextRow, MaxRow, K, Tree, N),

    if ResultRow == N ->
        {reply, [], State};
    true ->
        SeatsInRow = query_sum(1, 0, N-1, ResultRow, ResultRow, Tree),
        ColStart = M - SeatsInRow,

        NewSeatsInRow = SeatsInRow - K,
        NewTree = update_point(1, 0, N-1, ResultRow, NewSeatsInRow, Tree),

        NewNextRow = if ResultRow == NextRow andalso NewSeatsInRow == 0 ->
                           query_find_first_available_row(1, 0, N-1, NextRow + 1, N-1, 1, NewTree, N);
                       true ->
                           NextRow
                     end,
        {reply, [ResultRow, ColStart], State#state{tree=NewTree, next_row=NewNextRow}}
    end;

handle_call({scatter, K, MaxRow}, _From, State) ->
    #state{n=N, m=M, next_row=NextRow, tree=Tree} = State,

    EffectiveStartRow = query_find_first_available_row(1, 0, N-1, NextRow, MaxRow, 1, Tree, N),

    if EffectiveStartRow == N orElse EffectiveStartRow > MaxRow ->
        {reply, false, State};
    true ->
        TotalAvailableInRange = query_sum(1, 0, N-1, EffectiveStartRow, MaxRow, Tree),
        if TotalAvailableInRange < K ->
            {reply, false, State};
        true ->
            {LastRowIdx, _SeatsTaken} = find_prefix_target(1, 0, N-1, K, 0, EffectiveStartRow, MaxRow, Tree),

            NewTree = Tree,
            SeatsToFillCompletely = query_sum(1, 0, N-1, EffectiveStartRow, LastRowIdx - 1, NewTree),

            NewTree1 = if EffectiveStartRow <= LastRowIdx - 1 ->
                           update_range_set_to_zero(1, 0, N-1, EffectiveStartRow, LastRowIdx - 1, NewTree)
                       else
                           NewTree
                       end,

            RemainingK = K - SeatsToFillCompletely,

            NewTree2 = if RemainingK > 0 andalso LastRowIdx /= -1 ->
                           CurrentSeatsInLastRow = query_sum(1, 0, N-1, LastRowIdx, LastRowIdx, NewTree1),
                           NewSeatsInLastRow = CurrentSeatsInLastRow - RemainingK,
                           update_point(1, 0, N-1, LastRowIdx, NewSeatsInLastRow, NewTree1)
                       else
                           NewTree1
                       end,

            NewNextRow = query_find_first_available_row(1, 0, N-1, NextRow, N-1, 1, NewTree2, N),
            {reply, true, State#state{tree=NewTree2, next_row=NewNextRow}}
        end
    end;

handle_cast(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

build_tree(NodeIdx, NodeL, NodeR, M, Tree) ->
    if NodeL == NodeR ->
        array:set(NodeIdx, #node{max_s=M, sum_s=M, lazy=false}, Tree);
    true ->
        Mid = (NodeL + NodeR) div 2,
        Tree1 = build_tree(2*NodeIdx, NodeL, Mid, M, Tree),
        Tree2 = build_tree(2*NodeIdx+1, Mid+1, NodeR, M, Tree1),
        LeftNode = array:get(2*NodeIdx, Tree2),
        RightNode = array:get(2*NodeIdx+1, Tree2),
        array:set(NodeIdx, #node{max_s=max(LeftNode#node.max_s, RightNode#node.max_s), sum_s=LeftNode#node.sum_s + RightNode#node.sum_s, lazy=false}, Tree2)
    end.

push_down(NodeIdx, Tree) ->
    Node = array:get(NodeIdx, Tree),
    if Node#node.lazy == true ->
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        Tree1 = array:set(LeftChildIdx, (array:get(LeftChildIdx, Tree))#node{max_s=0, sum_s=0, lazy=true}, Tree),
        Tree2 = array:set(RightChildIdx, (array:get(RightChildIdx, Tree1))#node{max_s=0, sum_s=0, lazy=true}, Tree1),
        array:set(NodeIdx, Node#node{lazy=false}, Tree2);
    true ->
        Tree
    end.

update_point(NodeIdx, NodeL, NodeR, TargetIdx, NewVal, Tree) ->
    Tree1 = push_down(NodeIdx, Tree),
    if NodeL == NodeR ->
        array:set(NodeIdx, (array:get(NodeIdx, Tree1))#node{max_s=NewVal, sum_s=NewVal}, Tree1);
    true ->
        Mid = (NodeL + NodeR) div 2,
        Tree2 = if TargetIdx <= Mid ->
                    update_point(2*NodeIdx, NodeL, Mid, TargetIdx, NewVal, Tree1);
                true ->
                    update_point(2*NodeIdx+1, Mid+1, NodeR, TargetIdx, NewVal, Tree1)
                end,
        LeftNode = array:get(2*NodeIdx, Tree2),
        RightNode = array:get(2*NodeIdx+1, Tree2),
        array:set(NodeIdx, (array:get(NodeIdx, Tree2))#node{max_s=max(LeftNode#node.max_s, RightNode#node.max_s), sum_s=LeftNode#node.sum_s + RightNode#node.sum_s}, Tree2)
    end.

update_range_set_to_zero(NodeIdx, NodeL, NodeR, QueryL, QueryR, Tree) ->
    if QueryL > NodeR orElse QueryR < NodeL ->
        Tree;
    true ->
        Node = array:get(NodeIdx, Tree),
        if QueryL <= NodeL andalso NodeR <= QueryR ->
            array:set(NodeIdx, Node#node{max_s=0, sum_s=0, lazy=true}, Tree);
        true ->
            Tree1 = push_down(NodeIdx, Tree),
            Mid = (NodeL + NodeR) div 2,
            Tree2 = update_range_set_to_zero(2*NodeIdx, NodeL, Mid, QueryL, QueryR, Tree1),
            Tree3 = update_range_set_to_zero(2*NodeIdx+1, Mid+1, NodeR, QueryL, QueryR, Tree2),
            LeftNode = array:get(2*NodeIdx, Tree3),
            RightNode = array:get(2*NodeIdx+1, Tree3),
            array:set(NodeIdx, (array:get(NodeIdx, Tree3))#node{max_s=max(LeftNode#node.max_s, RightNode#node.max_s), sum_s=LeftNode#node.sum_s + RightNode#node.sum_s}, Tree3)
        end
    end.

query_sum(NodeIdx, NodeL, NodeR, QueryL, QueryR, Tree) ->
    if QueryL > NodeR orElse QueryR < NodeL ->
        0;
    true ->
        Node = array:get(NodeIdx, Tree),
        if QueryL <= NodeL andalso NodeR <= QueryR ->
            Node#node.sum_s;
        true ->
            Tree1 = push_down(NodeIdx, Tree),
            Mid = (NodeL + NodeR) div 2,
            SumL = query_sum(2*NodeIdx, NodeL, Mid, QueryL, QueryR, Tree1),
            SumR = query_sum(2*NodeIdx+1, Mid+1, NodeR, QueryL, QueryR, Tree1),
            SumL + SumR
        end
    end.

query_find_first_available_row(NodeIdx, NodeL, NodeR, QueryL, QueryR, MinSeats, Tree, TotalRows) ->
    if QueryL > NodeR orElse QueryR < NodeL ->
        TotalRows;
    true ->
        Node = array:get(NodeIdx, Tree),
        if Node#node.max_s < MinSeats ->
            TotalRows;
        true ->
            if NodeL == NodeR ->
                NodeL;
            true ->
                Tree1 = push_down(NodeIdx, Tree),
                Mid = (NodeL + NodeR) div 2,
                ResL = query_find_first_available_row(2*NodeIdx, NodeL, Mid, QueryL, QueryR, MinSeats, Tree1, TotalRows),
                if ResL /= TotalRows ->
                    ResL;
                true ->
                    query_find_first_available_row(2*NodeIdx+1, Mid+1, NodeR, QueryL, QueryR, MinSeats, Tree1, TotalRows)
                end
            end
        end
    end.

find_prefix_target(NodeIdx, NodeL, NodeR, TargetSum, CurrentSum, EffectiveQueryL, EffectiveQueryR, Tree) ->
    if NodeL > EffectiveQueryR orElse NodeR < EffectiveQueryL orElse TargetSum - CurrentSum =< 0 ->
        {-1, CurrentSum}; 
    true ->
        Node = array:get(NodeIdx, Tree),

        if CurrentSum + Node#node.sum_s <= TargetSum ->
            {NodeR, CurrentSum + Node#node.sum_s}; 
        true -> 
            if NodeL == NodeR -> 
                Take = min(Node#node.sum_s, TargetSum - CurrentSum),
                {NodeL, CurrentSum + Take};
            true ->
                Tree1 = push_down(NodeIdx, Tree),
                Mid = (NodeL + NodeR) div 2,

                {ResIdxL, ResSumL} = find_prefix_target(2*NodeIdx, NodeL, Mid, TargetSum, CurrentSum, EffectiveQueryL, EffectiveQueryR, Tree1),

                if ResSumL >= TargetSum -> 
                    {ResIdxL, ResSumL};
                true -> 
                    find_prefix_target(2*NodeIdx+1, Mid+1, NodeR, TargetSum, ResSumL, EffectiveQueryL, EffectiveQueryR, Tree1)
                end
            end
        end
    end.