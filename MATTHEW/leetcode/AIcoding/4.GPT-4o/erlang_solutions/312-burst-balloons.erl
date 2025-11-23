-spec max_coins(Nums :: [integer()]) -> integer().
max_coins(Nums) ->
    max_coins(Nums, []).

max_coins([], Acc) -> lists:sum(Acc);
max_coins([H | T], Acc) ->
    NewAcc = [H * hd(T) * tl(T)],
    max_coins(T, NewAcc).
