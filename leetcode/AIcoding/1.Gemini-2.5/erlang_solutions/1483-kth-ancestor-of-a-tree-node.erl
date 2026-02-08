-module(kth_ancestor).
-export([new/2, get_kth_ancestor/3]).

-record(tree_ancestor, {
    n :: integer(),
    max_log :: integer(),
    dp :: array:array() % array of arrays: dp[k] is an array mapping node -> ancestor
}).

new(N, Parent) ->
    % Calculate MaxLog: ceil(log2(N)). For N=1, log2(1)=0, so MaxLog=1.
    % For N=50000, log2(50000) approx 15.6, so MaxLog=16.
    MaxLog = erlang:trunc(math:log2(N - 1)) + 1,

    % Outer array to hold DP_k arrays. Indexed from 0 to MaxLog-1.
    DpTable = array:new(MaxLog),

    % DP0: 2^0-th ancestor (direct parent)
    DP0 = array:from_list(Parent),
    DpTable1 = array:set(0, DP0, DpTable),

    % Compute DP_k for k from 1 to MaxLog-1
    FinalDpTable = lists:foldl(
        fun(K, AccDpTable) ->
            PrevDP = array:get(K - 1, AccDpTable), % Get DP_{K-1}
            CurrentDP = array:new(N),
            CurrentDP_filled = lists:foldl(
                fun(Node, AccCurrentDP) ->
                    AncestorPrev = array:get(Node, PrevDP),
                    if
                        AncestorPrev == -1 ->
                            array:set(Node, -1, AccCurrentDP);
                        true ->
                            AncestorK = array:get(AncestorPrev, PrevDP),
                            array:set(Node, AncestorK, AccCurrentDP)
                    end
                end,
                CurrentDP,
                lists:seq(0, N - 1)
            ),
            array:set(K, CurrentDP_filled, AccDpTable)
        end,
        DpTable1,
        lists:seq(1, MaxLog - 1)
    ),

    #tree_ancestor{n = N, max_log = MaxLog, dp = FinalDpTable}.

get_kth_ancestor(Node, K, #tree_ancestor{max_log = MaxLog, dp = DpTable}) ->
    CurrentNode = Node,
    lists:foldl(
        fun(J, AccNode) ->
            if
                AccNode == -1 ->
                    -1;
                K band (1 bsl J) /= 0 -> % if J-th bit of K is set, move up by 2^J steps
                    array:get(AccNode, array:get(J, DpTable));
                true ->
                    AccNode
            end
        end,
        CurrentNode,
        lists:seq(MaxLog - 1, 0, -1) % Iterate from MaxLog-1 down to 0
    ).