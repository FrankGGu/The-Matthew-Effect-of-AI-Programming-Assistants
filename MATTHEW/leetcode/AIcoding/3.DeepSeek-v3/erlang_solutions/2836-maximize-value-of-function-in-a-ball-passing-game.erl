-module(solution).
-export([get_max_function_value/2]).

get_max_function_value(Receiver, K) ->
    N = length(Receiver),
    MaxBits = trunc(math:log2(K)) + 1,
    DP = lists:foldl(fun(Bit, Acc) ->
        lists:map(fun(I) ->
            case Bit of
                0 -> {lists:nth(I + 1, Receiver), lists:nth(I + 1, Receiver)};
                _ ->
                    {PrevNext, PrevSum} = lists:nth(I + 1, Acc),
                    {NextNext, NextSum} = lists:nth(PrevNext + 1, Acc),
                    {NextNext, PrevSum + NextSum}
            end
        end, lists:seq(0, N - 1))
    end, lists:duplicate(N, {0, 0}), lists:seq(0, MaxBits)),

    MaxValue = lists:foldl(fun(I, Acc) ->
        {Current, Sum} = {I, 0},
        {FinalPos, TotalSum} = lists:foldl(fun(Bit, {Pos, S}) ->
            if
                (K band (1 bsl Bit)) =/= 0 ->
                    {NextPos, NextSum} = lists:nth(Pos + 1, lists:nth(Bit + 1, DP)),
                    {NextPos, S + NextSum};
                true -> {Pos, S}
            end
        end, {Current, Sum}, lists:seq(0, MaxBits)),
        max(Acc, FinalPos + TotalSum)
    end, 0, lists:seq(0, N - 1)),
    MaxValue.