%% -spec get_skyline(Buildings :: [[integer()]]) -> [[integer()]].
get_skyline(Buildings) ->
    get_skyline(Buildings, [], []).

get_skyline([], Result, _) -> lists:reverse(Result);
get_skyline([[L, R, H] | Rest], Result, Heights) ->
    NewHeights = add_building(L, R, H, Heights),
    get_skyline(Rest, Result, NewHeights).

add_building(L, R, H, Heights) ->
    add_building(L, R, H, Heights, []).

add_building(_, R, _, [], Acc) -> [[R, 0] | lists:reverse(Acc)];
add_building(L, R, H, [{X, _} | T], Acc) when X >= R -> lists:reverse([{R, 0} | Acc]);
add_building(L, R, H, [{X, Y} | T], Acc) when X < L -> add_building(L, R, H, T, [{X, Y} | Acc]);
add_building(L, R, H, [{X, Y} | T], Acc) when X >= L andalso X < R ->
    NewHeight = max(Y, H),
    add_building(L, R, H, T, [{X, NewHeight} | Acc]).
