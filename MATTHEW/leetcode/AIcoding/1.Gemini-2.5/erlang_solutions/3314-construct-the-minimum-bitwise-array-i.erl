-module(solution).
-export([construct_minimum_bitwise_array/1]).

construct_minimum_bitwise_array(1) ->
    [0];
construct_minimum_bitwise_array(2) ->
    [0, 0];
construct_minimum_bitwise_array(N) when N >= 3 ->
    {ListPrefix, CurrentXOR} = lists:foldl(
        fun(I, {AccList, AccXOR}) ->
            {[I | AccList], AccXOR bxor I}
        end,
        {[], 0},
        lists:seq(1, N - 2)
    ),
    Prefix = lists:reverse(ListPrefix),

    A = 1 bsl 20,
    B = CurrentXOR bxor A,

    Prefix ++ [A, B].