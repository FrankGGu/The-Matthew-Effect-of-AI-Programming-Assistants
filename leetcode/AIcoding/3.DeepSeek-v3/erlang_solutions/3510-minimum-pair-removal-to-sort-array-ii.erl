-spec min_deletion(Nums :: [integer()]) -> integer().
min_deletion(Nums) ->
    min_deletion(Nums, 0, 0).

min_deletion([], _, Count) ->
    Count;
min_deletion([_], _, Count) ->
    Count;
min_deletion([X, Y | Rest], Prev, Count) when X =< Y andalso Y >= Prev ->
    min_deletion([Y | Rest], X, Count);
min_deletion([X, Y | Rest], Prev, Count) when X > Y ->
    min_deletion([X | Rest], Prev, Count + 1);
min_deletion([X, Y | Rest], Prev, Count) when Y < Prev ->
    min_deletion([X | Rest], Prev, Count + 1).