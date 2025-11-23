-spec max_sub_array(Nums :: [integer()]) -> integer().
max_sub_array(Nums) ->
    max_sub_array(Nums, 0, 0).

max_sub_array([], Max, _) -> Max;
max_sub_array([H | T], Max, Current) ->
    NewCurrent = max(H, Current + H),
    max_sub_array(T, max(Max, NewCurrent), NewCurrent).
