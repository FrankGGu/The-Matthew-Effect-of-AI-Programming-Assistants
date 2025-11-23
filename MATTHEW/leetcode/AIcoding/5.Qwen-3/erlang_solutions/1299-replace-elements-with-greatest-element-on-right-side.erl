-module(replace_elements).
-export([replace_elements/1]).

replace_elements(Nums) ->
    replace_elements(Nums, length(Nums) - 1, -1).

replace_elements([], _, _) ->
    [];
replace_elements([H | T], Index, MaxSoFar) ->
    Current = H,
    NewMax = max(MaxSoFar, Current),
    [NewMax | replace_elements(T, Index - 1, NewMax)].