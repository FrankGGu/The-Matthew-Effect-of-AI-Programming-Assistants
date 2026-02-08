-module(solution).
-export([rob/1]).

rob(Nums) ->
    N = length(Nums),
    if
        N == 0 -> 0;
        N == 1 -> hd(Nums);
        true ->
            % Subproblem 1: Rob houses from 0 to N-2 (excluding the last house)
            Subproblem1 = rob_linear(lists:sublist(Nums, 1, N - 1)),
            % Subproblem 2: Rob houses from 1 to N-1 (excluding the first house)
            Subproblem2 = rob_linear(lists:sublist(Nums, 2, N - 1)),
            max(Subproblem1, Subproblem2)
    end.

rob_linear(Nums) ->
    rob_linear(Nums, 0, 0).

rob_linear([], _Prev2, Prev1) ->
    Prev1;
rob_linear([H|T], Prev2, Prev1) ->
    Current = max(Prev1, Prev2 + H),
    rob_linear(T, Prev1, Current).