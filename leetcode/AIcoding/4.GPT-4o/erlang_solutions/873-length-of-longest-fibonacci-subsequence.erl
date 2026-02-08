-module(solution).
-export([len_fib_subseq/1]).

len_fib_subseq(A) ->
    N = length(A),
    Map = maps:from_list([{X, I} || {X, I} <- lists:zip(A, lists:seq(1, N))]),
    fib_map(A, Map, N, 0).

fib_map([], _, _, Max) -> Max;
fib_map([H | T], Map, N, Max) ->
    case find_fib(T, H, Map, N) of
        {NewMax, _} -> fib_map(T, Map, N, max(Max, NewMax));
        _ -> fib_map(T, Map, N, Max)
    end.

find_fib([], _, _, _) -> {0, []};
find_fib([H | T], Prev, Map, N) ->
    case maps:is_key(Prev + H, Map) of
        true ->
            {Length, Seq} = find_fib(T, H, Map, N),
            {Length + 1, [H | Seq]};
        false -> find_fib(T, Prev, Map, N)
    end.