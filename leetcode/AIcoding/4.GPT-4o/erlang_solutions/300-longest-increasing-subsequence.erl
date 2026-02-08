-spec length_of_lis(Nums :: [integer()]) -> integer().
length_of_lis(Nums) ->
    length_of_lis(Nums, []).

length_of_lis([], L) -> length(L);
length_of_lis([H | T], L) ->
    length_of_lis(T, [X || X <- L, X < H] ++ [H | L]).
