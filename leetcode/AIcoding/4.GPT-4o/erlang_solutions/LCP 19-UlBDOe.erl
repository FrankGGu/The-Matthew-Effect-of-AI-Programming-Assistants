-module(solution).
-export([collect_leaves/1]).

collect_leaves(N) when N < 1 -> 0;
collect_leaves(N) -> 
    collect_leaves_helper(N, 0, 0).

collect_leaves_helper(0, Collected, _) -> Collected;
collect_leaves_helper(N, Collected, Last) ->
    NewLeaves = N div 2,
    collect_leaves_helper(NewLeaves, Collected + N, N).