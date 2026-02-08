-module(mkaverage).
-export([new/2, add_element/2, calculate_average/1]).

-record(mkaverage, {
    m :: integer(),
    k :: integer(),
    q :: queue:queue(),
    left_tree :: gb_trees:tree(),
    middle_tree :: gb_trees:tree(),
    right_tree :: gb_trees:tree(),
    left_sum :: integer(),
    middle_sum :: integer(),
    right_sum :: integer(),
    left_count :: integer(),
    middle_count :: integer(),
    right_count :: integer()
}).

new(M, K) ->
    #mkaverage{
        m = M,
        k = K,
        q = queue:new(),
        left_tree = gb_trees:empty(),
        middle_tree = gb_trees:empty(),
        right_tree = gb_trees:empty(),
        left_sum = 0,
        middle_sum = 0,
        right_sum = 0,
        left_count = 0,
        middle_count = 0,
        right_count = 0
    }.

add_element(Val, State0) ->
    #mkaverage{m = M, q = Q0} = State0,

    Q1 = queue:in(Val, Q0),
    State1 = State0#mkaverage{q = Q1},

    State2 =
        if queue:len(Q1) > M ->
            {OldestVal, Q2} = queue:out(Q1),
            remove_val(OldestVal, State1#mkaverage{q = Q2});
        true ->
            State1
        end,

    State3 = add_val(Val, State2),
    rebalance_all_trees(State3).

calculate_average(State) ->
    #mkaverage{m = M, q = Q, middle_sum = MS, middle_count = MC} = State,
    if queue:len(Q) < M orelse MC == 0 ->
        -1;
    true ->
        MS div MC
    end.

add_to_tree(Val, Tree, Sum, Count) ->
    NewTree = gb_trees:update_counter(Val, 1, Tree),
    {NewTree, Sum + Val, Count + 1}.

remove_from_tree(Val, Tree, Sum, Count) ->
    case gb_trees:lookup(Val, Tree) of
        {value, Cnt} when Cnt > 1 ->
            NewTree = gb_trees:update_counter(Val, -1, Tree),
            {NewTree, Sum - Val, Count - 1};
        {value, 1} ->
            NewTree = gb_trees:delete(Val, Tree),
            {NewTree, Sum - Val, Count - 1};
        _ ->
            {Tree, Sum, Count}
    end.

move_max(FromTree, FromSum, FromCount, ToTree, ToSum, ToCount) ->
    case gb_trees:is_empty(FromTree) of
        true -> {FromTree, FromSum, FromCount, ToTree, ToSum, ToCount};
        false ->
            MaxVal = gb_trees:get_max_key(FromTree),
            {FromTree1, FromSum1, FromCount1} = remove_from_tree(MaxVal, FromTree, FromSum, FromCount),
            {ToTree1, ToSum1, ToCount1} = add_to_tree(MaxVal, ToTree, ToSum, ToCount),
            {FromTree1, FromSum1, FromCount1, ToTree1, ToSum1, ToCount1}
    end.

move_min(FromTree, FromSum, FromCount, ToTree, ToSum, ToCount) ->
    case gb_trees:is_empty(FromTree) of
        true -> {FromTree, FromSum, FromCount, ToTree, ToSum, ToCount};
        false ->
            MinVal = gb_trees:get_min_key(FromTree),
            {FromTree1, FromSum1, FromCount1} = remove_from_tree(MinVal, FromTree, FromSum, FromCount),
            {ToTree1, ToSum1, ToCount1} = add_to_tree(MinVal, ToTree, ToSum, ToCount),
            {FromTree1, FromSum1, FromCount1, ToTree1, ToSum1, ToCount1}
    end.

add_val(Val, State) ->
    #mkaverage{middle_tree = MTree, middle_sum = MSum, middle_count = MCount} = State,
    {NewMTree, NewMSum, NewMCount} = add_to_tree(Val, MTree, MSum, MCount),
    State#mkaverage{middle_tree = NewMTree, middle_sum = NewMSum, middle_count = NewMCount}.

remove_val(Val, State) ->
    #mkaverage{left_tree = LTree, middle_tree = MTree, right_tree = RTree,
               left_sum = LSum, middle_sum = MSum, right_sum = RSum,
               left_count = LCount, middle_count = MCount, right_count = RCount} = State,

    if gb_trees:is_defined(Val, LTree) ->
        {NewLTree, NewLSum, NewLCount} = remove_from_tree(Val, LTree, LSum, LCount),
        State#mkaverage{left_tree = NewLTree, left_sum = NewLSum, left_count = NewLCount};
    gb_trees:is_defined(Val, MTree) ->
        {NewMTree, NewMSum, NewMCount} = remove_from_tree(Val, MTree, MSum, MCount),
        State#mkaverage{middle_tree = NewMTree, middle_sum = NewMSum, middle_count = NewMCount};
    gb_trees:is_defined(Val, RTree) ->
        {NewRTree, NewRSum, NewRCount} = remove_from_tree(Val, RTree, RSum, RCount),
        State#mkaverage{right_tree = NewRTree, right_sum = NewRSum, right_count = NewRCount};
    true ->
        State
    end.

rebalance_all_trees(State) ->
    rebalance_loop(State, true).

rebalance_loop(State, false) -> State;
rebalance_loop(State0, true) ->
    #mkaverage{k = K} = State0,

    Changed = false,
    CurrentState = State0,

    % 1. Move largest from L to M if L is too big
    {CurrentState1, C1} = move_max_if_too_big(CurrentState, left, K),
    CurrentState = CurrentState1, Changed = Changed orelse C1,

    % 2. Move smallest from R to M if R is too big
    {CurrentState2, C2} = move_min_if_too_big(CurrentState, right, K),
    CurrentState = CurrentState2, Changed = Changed orelse C2,

    % 3. Move smallest from M to L if L is too small
    {CurrentState3, C3} = move_min_if_too_small(CurrentState, left, K),
    CurrentState = CurrentState3, Changed = Changed orelse C3,

    % 4. Move largest from M to R if R is too small
    {CurrentState4, C4} = move_max_if_too_small(CurrentState, right, K),
    CurrentState = CurrentState4, Changed = Changed orelse C4,

    % 5. Swap L and M if out of order
    {CurrentState5, C5} = swap_if_out_of_order(CurrentState, left, middle),
    CurrentState = CurrentState5, Changed = Changed orelse C5,

    % 6. Swap M and R if out of order
    {CurrentState6, C6} = swap_if_out_of_order(CurrentState, middle, right),
    CurrentState = CurrentState6, Changed = Changed orelse C6,

    rebalance_loop(CurrentState, Changed).

move_max_if_too_big(State, left, K) ->
    #mkaverage{left_tree = LTree, middle_tree = MTree,
               left_sum = LSum, middle_sum = MSum,
               left_count = LCount, middle_count = MCount} = State,
    if LCount > K ->
        {LTreeX, LSumX, LCountX, MTreeX, MSumX, MCountX} = move_max(LTree, LSum, LCount, MTree, MSum, MCount),
        {State#mkaverage{left_tree = LTreeX, left_sum = LSumX, left_count = LCountX,
                         middle_tree = MTreeX, middle_sum = MSumX, middle_count = MCountX}, true};
    true -> {State, false}
    end.

move_min_if_too_big(State, right, K) ->
    #mkaverage{middle_tree = MTree, right_tree = RTree,
               middle_sum = MSum, right_sum = RSum,
               middle_count = MCount, right_count = RCount} = State,
    if RCount > K ->
        {RTreeX, RSumX, RCountX, MTreeX, MSumX, MCountX} = move_min(RTree, RSum, RCount, MTree, MSum, MCount),
        {State#mkaverage{middle_tree = MTreeX, middle_sum = MSumX, middle_count = MCountX,
                         right_tree = RTreeX, right_sum = RSumX, right_count = RCountX}, true};
    true -> {State, false}
    end.

move_min_if_too_small(State, left, K) ->
    #mkaverage{left_tree = LTree, middle_tree = MTree,
               left_sum = LSum, middle_sum = MSum,
               left_count = LCount, middle_count = MCount} = State,
    if LCount < K andalso MCount > 0 ->
        {MTreeX, MSumX, MCountX, LTreeX, LSumX, LCountX} = move_min(MTree, MSum, MCount, LTree, LSum, LCount),
        {State#mkaverage{left_tree = LTreeX, left_sum = LSumX, left_count = LCountX,
                         middle_tree = MTreeX, middle_sum = MSumX, middle_count = MCountX}, true};
    true -> {State, false}
    end.

move_max_if_too_small(State, right, K) ->
    #mkaverage{middle_tree = MTree, right_tree = RTree,
               middle_sum = MSum, right_sum = RSum,
               middle_count = MCount, right_count = RCount} = State,
    if RCount < K andalso MCount > 0 ->
        {MTreeX, MSumX, MCountX, RTreeX, RSumX, RCountX} = move_max(MTree, MSum, MCount, RTree, RSum, RCount),
        {State#mkaverage{middle_tree = MTreeX, middle_sum = MSumX, middle_count = MCountX,
                         right_tree = RTreeX, right_sum = RSumX, right_count = RCountX}, true};
    true -> {State, false}
    end.

swap_if_out_of_order(State, left, middle) ->
    #mkaverage{left_tree = LTree, middle_tree = MTree,
               left_sum = LSum, middle_sum = MSum,
               left_count = LCount, middle_count = MCount} = State,
    if LCount > 0 andalso MCount > 0 andalso gb_trees:get_max_key(LTree) > gb_trees:get_min_key(MTree) ->
        MaxL = gb_trees:get_max_key(LTree),
        MinM = gb_trees:get_min_key(MTree),
        {LTree1, LSum1, LCount1} = remove_from_tree(MaxL, LTree, LSum, LCount),
        {MTree1, MSum1, MCount1} = add_to_tree(MaxL, MTree, MSum, MCount),
        {MTree2, MSum2, MCount2} = remove_from_tree(MinM, MTree1, MSum1, MCount1),
        {LTree2, LSum2, LCount2} = add_to_tree(MinM, LTree1, LSum1, LCount1),
        {State#mkaverage{left_tree = LTree2, left_sum = LSum2, left_count = LCount2,
                         middle_tree = MTree2, middle_sum = MSum2, middle_count = MCount2}, true};
    true -> {State, false}
    end.

swap_if_out_of_order(State, middle, right) ->
    #mkaverage{middle_tree = MTree, right_tree = RTree,
               middle_sum = MSum, right_sum = RSum,
               middle_count = MCount, right_count = RCount} = State,
    if MCount > 0 andalso RCount > 0 andalso gb_trees:get_max_key(MTree) > gb_trees:get_min_key(RTree) ->
        MaxM = gb_trees:get_max_key(MTree),
        MinR = gb_trees:get_min_key(RTree),
        {MTreeB, MSumB, MCountB} = remove_from_tree(MaxM, MTree, MSum, MCount),
        {RTreeB, RSumB, RCountB} = add_to_tree(MaxM, RTree, RSum, RCount),
        {RTreeC, RSumC, RCountC} = remove_from_tree(MinR, RTreeB, RSumB, RCountB),
        {MTreeC, MSumC, MCountC} = add_to_tree(MinR, MTreeB, MSumB, MCountB),
        {State#mkaverage{middle_tree = MTreeC, middle_sum = MSumC, middle_count = MCountC,
                         right_tree = RTreeC, right_sum = RSumC, right_count = RCountC}, true};
    true -> {State, false}
    end.