-spec minimum_replacement(Nums :: [integer()]) -> integer().
minimum_replacement(Nums) ->
    minimum_replacement(Nums, 0).

minimum_replacement([], Count) -> Count;
minimum_replacement([_], Count) -> Count;
minimum_replacement([X, Y | Rest], Count) when X =< Y ->
    minimum_replacement([Y | Rest], Count);
minimum_replacement([X, Y | Rest], Count) when X > Y ->
    K = (X + Y - 1) div Y,
    NewCount = Count + K - 1,
    NewY = X div K,
    minimum_replacement([NewY, Y | Rest], NewCount).