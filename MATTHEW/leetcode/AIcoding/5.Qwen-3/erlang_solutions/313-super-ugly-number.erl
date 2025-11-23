-module(superglue).
-export([nth_super_ugly_number/2]).

nth_super_ugly_number(N, Primes) ->
    Ugly = array:new(N, {default, 1}),
    Indices = array:new(length(Primes), {default, 0}),
    lists:foldl(fun _I -> 
        Next = lists:min([array:get(I, Ugly) * lists:nth(I+1, Primes) || I <- lists:seq(0, length(Primes)-1)]),
        array:set(N-1, Next, Ugly)
    end, Ugly, lists:seq(1, N-1)),
    array:get(N-1, Ugly).

array:get(Index, Array) -> erlang:element(Index + 1, Array).
array:set(Index, Value, Array) -> erlang:list_to_tuple(lists:sublist(tuple_to_list(Array), Index) ++ [Value] ++ lists:nthtail(Index + 1, tuple_to_list(Array))).
array:new(Size, _) -> erlang:list_to_tuple(lists:duplicate(Size, 1)).