-spec move_zeroes(Nums :: [integer()]) -> [integer()].
move_zeroes(Nums) ->
    move_zeroes(Nums, 0, []).

move_zeroes([], _, Acc) -> lists:reverse(Acc);
move_zeroes([0 | T], Count, Acc) -> move_zeroes(T, Count + 1, Acc);
move_zeroes([H | T], Count, Acc) -> move_zeroes(T, Count, [H | Acc]).
