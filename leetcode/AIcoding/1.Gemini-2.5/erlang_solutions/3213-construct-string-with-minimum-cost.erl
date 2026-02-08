-module(solution).
-export([min_cost_to_construct/3]).

min_cost_to_construct(Target, Words, Costs) ->
    N = length(Target),
    Infinity = 1_000_000_000_000, % A sufficiently large number for infinity

    % Pre-process words and costs into a list of {Word, Cost, WordLen} tuples
    WordData = lists:map(fun({Word, Cost}) -> {Word, Cost, length(Word)} end, lists:zip(Words, Costs)),

    % Initialize DP array: dp[0] = 0, dp[i] = Infinity for i > 0
    % Using an array module for mutable-like access
    DP = array:new([{size, N + 1}, {fixed, true}, {default, Infinity}]),
    DP1 = array:set(0, 0, DP),

    % Iterate i from 1 to N (current target prefix length)
    DP_final = lists:foldl(
        fun(I, CurrentDP) ->
            % For each word and its cost and length
            lists:foldl(
                fun({Word, Cost, WordLen}, InnerDP) ->
                    If I >= WordLen ->
                        PrevIdx = I - WordLen,
                        % Check if target[PrevIdx...I-1] (0-based) matches Word
                        % lists:sublist is 1-based for start index
                        SubTarget = lists:sublist(Target, PrevIdx + 1, WordLen),
                        If SubTarget == Word ->
                            PrevCost = array:get(PrevIdx, InnerDP),
                            If PrevCost /= Infinity -> % Only update if PrevIdx was reachable
                                CurrentCost = array:get(I, InnerDP),
                                NewCost = PrevCost + Cost,
                                If NewCost < CurrentCost ->
                                    array:set(I, NewCost, InnerDP)
                                Else
                                    InnerDP
                                End
                            Else
                                InnerDP
                            End
                        Else
                            InnerDP
                        End
                    Else
                        InnerDP
                    End
                End,
                CurrentDP,
                WordData
            )
        End,
        DP1,
        lists:seq(1, N)
    ),

    Result = array:get(N, DP_final),
    If Result == Infinity ->
        -1
    Else
        Result
    End.