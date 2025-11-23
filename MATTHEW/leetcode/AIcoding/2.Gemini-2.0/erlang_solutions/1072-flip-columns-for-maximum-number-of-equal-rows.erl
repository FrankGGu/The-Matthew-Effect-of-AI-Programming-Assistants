-module(flip_columns).
-export([max_equal_rows_after_flipping/1]).

max_equal_rows_after_flipping(Matrix) ->
    max_equal_rows_after_flipping(Matrix, {}).

max_equal_rows_after_flipping([], Acc) ->
    lists:max([V || {_, V} <- dict:to_list(Acc)]);
max_equal_rows_after_flipping([Row | Rest], Acc) ->
    Flipped_Row = [1 - X || X <- Row],
    Row_Tuple = list_to_tuple(Row),
    Flipped_Row_Tuple = list_to_tuple(Flipped_Row),

    Acc1 = case dict:is_key(Row_Tuple, Acc) of
               true -> dict:update(Row_Tuple, fun(V) -> V + 1 end, Acc);
               false -> dict:put(Row_Tuple, 1, Acc)
           end,

    Acc2 = case dict:is_key(Flipped_Row_Tuple, Acc1) of
               true -> dict:update(Flipped_Row_Tuple, fun(V) -> V + 1 end, Acc1);
               false -> dict:put(Flipped_Row_Tuple, 1, Acc1)
           end,

    max_equal_rows_after_flipping(Rest, Acc2).