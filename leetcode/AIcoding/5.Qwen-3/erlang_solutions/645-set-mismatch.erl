-module(solution).
-export([find_error_nums/1]).

find_error_nums(Nums) ->
    N = length(Nums),
    {Missing, Duplicate} = lists:foldl(
        fun(X, {Miss, Dup}) ->
            case lists:member(X, Dup) of
                true -> {Miss, [X | Dup]};
                false -> {lists:delete(X, Miss), [X | Dup]}
            end
        end,
        {lists:seq(1, N), []},
        Nums
    ),
    [lists:last(Duplicate), Missing].

lists:delete(X, [X|T]) -> T;
lists:delete(X, [H|T]) -> [H | lists:delete(X, T)];
lists:delete(_, []) -> [].