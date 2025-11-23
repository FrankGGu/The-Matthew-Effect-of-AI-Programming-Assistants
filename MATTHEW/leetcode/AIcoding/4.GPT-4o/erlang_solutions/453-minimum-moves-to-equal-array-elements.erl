-module(solution).
-export([min_moves/1]).

-spec min_moves([integer()]) -> integer().
min_moves(Nums) ->
    Min = lists:min(Nums),
    lists:sum(lists:map(fun(X) -> X - Min end, Nums)).
