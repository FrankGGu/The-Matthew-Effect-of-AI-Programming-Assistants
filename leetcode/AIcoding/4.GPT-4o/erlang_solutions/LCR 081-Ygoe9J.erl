-module(solution).
-export([combination_sum/2]).

combination_sum(Target, Candidates) ->
    combination_sum(Target, Candidates, [], []).

combination_sum(0, _, Path) -> 
    [lists:reverse(Path)];
combination_sum(Target, [], _) -> 
    [];
combination_sum(Target, [H | T], Path) when Target >= H ->
    combination_sum(Target - H, [H | T], [H | Path]) ++ combination_sum(Target, T, Path);
combination_sum(Target, [_ | T], Path) ->
    combination_sum(Target, T, Path).