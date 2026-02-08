-module(solution).
-export([at_most_n_given_digit_set/2]).

at_most_n_given_digit_set(Digits, N) ->
    S = integer_to_list(N),
    K = length(S),
    D = length(Digits),
    DP = lists:duplicate(K + 1, 0),
    {DP1, _} = lists:foldl(fun(I, {DPAcc, _}) ->
        NewDP = setelement(I + 1, DPAcc, 0),
        {NewDP, I}
    end, {list_to_tuple(DP), 0}, lists:seq(0, K - 1)),
    DP2 = setelement(K + 1, DP1, 1),
    {DP3, _} = lists:foldl(fun(I, {DPAcc, _}) ->
        Si = lists:nth(K - I, S) - $0,
        Sum = lists:foldl(fun(D, Acc) ->
            DVal = list_to_integer([D]),
            if DVal < Si -> Acc + 1; true -> Acc end
        end, 0, Digits),
        NewVal = Sum * trunc(math:pow(D, I)),
        Current = element(K - I + 1, DPAcc),
        NewDP = setelement(K - I + 1, DPAcc, Current + NewVal),
        case lists:member(Si, [list_to_integer([D]) || D <- Digits]) of
            true -> {NewDP, I};
            false -> {NewDP, I}
        end
    end, {DP2, 0}, lists:seq(0, K - 1)),
    Total = lists:foldl(fun(I, Acc) ->
        Acc + trunc(math:pow(D, I))
    end, 0, lists:seq(1, K - 1)),
    case lists:foldl(fun(D, Acc) ->
        DVal = list_to_integer([D]),
        if DVal =< N -> Acc + 1; true -> Acc end
    end, 0, Digits) of
        Valid when Valid > 0 -> Total + element(1, DP3);
        _ -> Total
    end.