-module(solution).
-export([rank_transform/1]).

rank_transform(Matrix) ->
    Lists = lists:flatten(Matrix),
    Unique = lists:usort(Lists),
    Ranks = lists:zip(Unique, lists:seq(1, length(Unique))),
    ranks_to_matrix(Ranks, Matrix).

ranks_to_matrix(Ranks, Matrix) ->
    RanksMap = maps:from_list(Ranks),
    lists:map(fun(Row) -> lists:map(fun(X) -> maps:get(X, RanksMap) end, Row) end, Matrix).