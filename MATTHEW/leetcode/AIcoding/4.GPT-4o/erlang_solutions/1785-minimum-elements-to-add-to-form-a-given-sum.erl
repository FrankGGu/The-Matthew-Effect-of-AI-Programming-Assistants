-module(solution).
-export([min_elements/2]).

min_elements(Target, nums) ->
    min_elements(Target, nums, 0).

min_elements(Target, [], Count) when Target > 0 -> 
    Count + ceil(Target / 1).
min_elements(Target, [H | T], Count) when Target > 0 ->
    NewTarget = Target - H,
    min_elements(NewTarget, T, Count + 1);
min_elements(Target, [_ | T], Count) ->
    min_elements(Target, T, Count).