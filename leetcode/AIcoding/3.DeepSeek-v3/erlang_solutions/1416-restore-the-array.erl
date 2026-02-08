-module(solution).
-export([number_of_arrays/2]).

number_of_arrays(S, K) ->
    N = length(S),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(N, 1, DP),
    number_of_arrays(S, K, 0, DP1).

number_of_arrays(S, K, I, DP) ->
    case array:get(I, DP) of
        0 ->
            Res = case lists:nth(I + 1, S) of
                $0 -> 0;
                _ ->
                    lists:foldl(fun(J, Acc) ->
                        case J > I + 10 of
                            true -> Acc;
                            false ->
                                Num = list_to_integer(lists:sublist(S, I + 1, J - I)),
                                case Num =< K of
                                    true -> (Acc + array:get(J, DP)) rem 1000000007;
                                    false -> Acc
                                end
                        end
                    end, 0, lists:seq(I + 1, min(I + 10, length(S))))
            end,
            DP1 = array:set(I, Res, DP),
            number_of_arrays(S, K, I, DP1);
        Val -> Val
    end.