%% -spec min_path_sum(Grid :: [[integer()]]) -> integer().
min_path_sum(Grid) ->
    min_path_sum(Grid, 0, 0, []).

min_path_sum([], _, _, Acc) -> lists:sum(Acc);
min_path_sum([Row | Rest], X, Y, Acc) ->
    min_path_sum(Rest, X + 1, Y + 1, [lists:min([X, Y]) | Acc]).
