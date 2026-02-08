-spec left_right_difference(Nums :: [integer()]) -> [integer()].
left_right_difference(Nums) ->
    LeftSum = left_sum(Nums),
    RightSum = right_sum(Nums),
    lists:zipwith(fun(L, R) -> abs(L - R) end, LeftSum, RightSum).

left_sum(Nums) ->
    left_sum(Nums, 0, []).

left_sum([], _, Acc) ->
    lists:reverse(Acc);
left_sum([H | T], Sum, Acc) ->
    left_sum(T, Sum + H, [Sum | Acc]).

right_sum(Nums) ->
    right_sum(Nums, 0, []).

right_sum([], _, Acc) ->
    Acc;
right_sum([H | T], Sum, Acc) ->
    right_sum(T, Sum + H, [Sum | Acc]).