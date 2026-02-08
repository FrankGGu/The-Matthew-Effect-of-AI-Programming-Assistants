-module(odd_even_jump).
-export([oddEvenJumps/1]).

oddEvenJumps(Numbers) ->
    N = length(Numbers),
    Sorted = lists:sort([{Num, I} || {I, Num} <- lists:zip(lists:seq(0, N-1), Numbers)]),
    NextOdd = array:new([{size, N}, {default, -1}]),
    NextEven = array:new([{size, N}, {default, -1}]),
    build_next(Sorted, 0, NextOdd, NextEven),
    {Odd, Even} = build_jumps(Numbers, N, NextOdd, NextEven),
    [Odd, Even].

build_next([], _, NextOdd, NextEven) -> {NextOdd, NextEven};
build_next([{Num, I} | Rest], Index, NextOdd, NextEven) ->
    case Rest of
        [] -> build_next(Rest, Index + 1, NextOdd, NextEven);
        _ ->
            case lists:keyfind(Num, 1, Rest) of
                false ->
                    build_next(Rest, Index + 1, NextOdd, NextEven);
                {Num, J} ->
                    NextOdd1 = array:set(I, J, NextOdd),
                    NextEven1 = array:set(I, J, NextEven),
                    build_next(Rest, Index + 1, NextOdd1, NextEven1)
            end
    end.

build_jumps(_, 0, _, _) -> {0, 0};
build_jumps(Numbers, N, NextOdd, NextEven) ->
    {Odd, Even} = build_jumps(Numbers, N - 1, NextOdd, NextEven),
    Current = lists:nth(N, Numbers),
    NextOddIndex = array:get(N - 1, NextOdd),
    NextEvenIndex = array:get(N - 1, NextEven),
    if
        NextOddIndex /= -1 ->
            {Odd + 1, Even};
        true ->
            {Odd, Even}
    end.