-spec max_sub_array(Nums :: [integer()]) -> integer().
max_sub_array(Nums) ->
    max_sub_array(Nums, 0, -1000000).

max_sub_array([], Current, Max) ->
    Max;
max_sub_array([H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(NewCurrent, Max),
    max_sub_array(T, NewCurrent, NewMax).