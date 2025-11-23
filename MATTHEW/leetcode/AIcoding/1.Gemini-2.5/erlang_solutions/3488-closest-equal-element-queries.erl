-module(solution).
-export([closest_equal_element_queries/2]).

-define(INF, 100001). % Max possible distance is N-1, N <= 10^5. So 100001 is good for infinity.

seg_tree_new(Size) ->
    Nodes = array:new(2 * Size, {default, ?INF}),
    {Size, Nodes}.

seg_tree_update({Size, Nodes}, Index, Value) ->
    ActualIndex = Index + Size, % Map user 0-based index to leaf index
    NewNodes1 = array:set(ActualIndex, Value, Nodes),
    seg_tree_update_up({Size, NewNodes1}, ActualIndex div 2).

seg_tree_update_up({Size, Nodes}, CurrentIdx) when CurrentIdx >= 1 ->
    LeftChildVal = array:get(2 * CurrentIdx, Nodes),
    RightChildVal = array:get(2 * CurrentIdx + 1, Nodes),
    NewVal = min(LeftChildVal, RightChildVal),
    NewNodes = array:set(CurrentIdx, NewVal, Nodes),
    seg_tree_update_up({Size, NewNodes}, CurrentIdx div 2);
seg_tree_update_up(Tree, _CurrentIdx) ->
    Tree.

seg_tree_query({Size, Nodes}, Left, Right) ->
    % Handle invalid query ranges
    if Left > Right ->
        ?INF;
    true ->
        QueryLeft = Left + Size,
        QueryRight = Right + Size,
        seg_tree_query_down(Nodes, QueryLeft, QueryRight, ?INF)
    end.

seg_tree_query_down(Nodes, L, R, Acc) when L =< R ->
    NewAcc1 = if
                  (L rem 2 == 1) -> min(Acc, array:get(L, Nodes));
                  true -> Acc
              end,
    NewL = if
               (L rem 2 == 1) -> L + 1;
               true -> L
           end,
    NewAcc2 = if
                  (R rem 2 == 0) -> min(NewAcc1, array:get(R, Nodes));
                  true -> NewAcc1
              end,
    NewR = if
               (R rem 2 == 0) -> R - 1;
               true -> R
           end,
    seg_tree_query_down(Nodes, NewL div 2, NewR div 2, NewAcc2);
seg_tree_query_down(_Nodes, _L, _R, Acc) ->
    Acc.

closest_equal_element_queries(Nums, Queries) ->
    N = length(Nums),
    Q = length(Queries),

    %% 1. Precompute events (i, dist, j)
    %% Map: Value -> List of indices where it appears (reversed for O(1) prepend)
    ValToIndices = maps:new(),
    ValToIndices1 = build_val_to_indices(Nums, 0, ValToIndices),

    Events = build_events(ValToIndices1),

    %% Group events by j (val_idx)
    EventsByJ = array:new(N, {default, []}),
    EventsByJ1 = lists:foldl(fun({I, Dist, J}, Acc) ->
                                 CurrentEvents = array:get(J, Acc),
                                 array:set(J, [{I, Dist} | CurrentEvents], Acc)
                             end, EventsByJ, Events),

    %% 2. Group queries by right endpoint
    QueriesByRight = maps:new(),
    QueriesByRight1 = build_queries_by_right(Queries, 0, QueriesByRight),

    %% 3. Initialize segment tree
    SegTree = seg_tree_new(N),

    %% 4. Initialize answers array
    Answers = array:new(Q, {default, -1}),

    %% 5. Iterate j from 0 to N-1
    process_j(0, N, EventsByJ1, QueriesByRight1, SegTree, Answers).

build_val_to_indices([], _Idx, Acc) -> Acc;
build_val_to_indices([H|T], Idx, Acc) ->
    NewAcc = maps:update_with(H, fun(L) -> [Idx|L] end, [Idx], Acc),
    build_val_to_indices(T, Idx + 1, NewAcc).

build_events(ValToIndices) ->
    lists:flatmap(fun({_Val, IndicesReversed}) ->
                      build_events_for_val(lists:reverse(IndicesReversed)) % Reverse to get ascending order
                  end, maps:to_list(ValToIndices)).

build_events_for_val(Indices) ->
    build_events_for_val(Indices, []).

build_events_for_val([_], Acc) -> lists:reverse(Acc); % Base case: single index, no pair
build_events_for_val([I1, I2 | Rest], Acc) ->
    Event = {I1, I2 - I1, I2},
    build_events_for_val([I2 | Rest], [Event | Acc]).

build_queries_by_right([], _QueryIdx, Acc) -> Acc;
build_queries_by_right([[L, R]|T], QueryIdx, Acc) ->
    NewAcc = maps:update_with(R, fun(List) -> [{L, QueryIdx} | List] end, [{L, QueryIdx}], Acc),
    build_queries_by_right(T, QueryIdx + 1, NewAcc).

process_j(J, N, EventsByJ, QueriesByRight, SegTree, Answers) when J >= N ->
    array:to_list(Answers);
process_j(J, N, EventsByJ, QueriesByRight, SegTree, Answers) ->
    %% a. Process all events (I, Dist) where J is the right endpoint
    CurrentEvents = array:get(J, EventsByJ),
    NewSegTree = lists:foldl(fun({I, Dist}, AccSegTree) ->
                                 seg_tree_update(AccSegTree, I, Dist)
                             end, SegTree, CurrentEvents),

    %% b. Process all queries where J is the right endpoint
    CurrentQueries = maps:get(J, QueriesByRight, []),
    NewAnswers = lists:foldl(fun({L, QueryIdx}, AccAnswers) ->
                                 MinVal = seg_tree_query(NewSegTree, L, J - 1), % Query range [L, J-1]
                                 Result = if
                                             MinVal == ?INF -> -1;
                                             true -> MinVal
                                         end,
                                 array:set(QueryIdx, Result, AccAnswers)
                             end, Answers, CurrentQueries),

    process_j(J + 1, N, EventsByJ, QueriesByRight, NewSegTree, NewAnswers).