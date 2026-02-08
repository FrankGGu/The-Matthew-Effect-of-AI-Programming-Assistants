-module(solution).
-export([len_fib_subseq/1]).

len_fib_subseq(Nums) ->
    N = length(Nums),
    Map = maps:from_list([{Nums[Index], Index} || Index <- lists:seq(0, N - 1)]),
    fib(Nums, Map, N, 0, 0).

fib([], _, _, MaxLen, _CurLen) -> MaxLen;
fib([H | T], Map, N, MaxLen, CurLen) ->
    Next = lists:nth(1, T),
    case maps:is_key(Next, Map) of
        true ->
            NewLen = CurLen + 1,
            NewMax = max(MaxLen, NewLen),
            fib(T, Map, N, NewMax, NewLen);
        false ->
            fib(T, Map, N, MaxLen, 0)
    end.