-module(restore_the_array).
-export([number_of_ways/2]).

number_of_ways(S, K) ->
    N = erlang:length(S),
    DP = array:new(N+1, {default, 0}),
    DP1 = array:set(0, 1, DP),
    lists:foldl(fun(I, Acc) ->
        case array:get(I-1, Acc) of
            0 -> Acc;
            _ ->
                case I+1 > N of
                    true -> Acc;
                    false ->
                        case string:substr(S, I+1, 1) of
                            "0" -> Acc;
                            _ ->
                                lists:foldl(fun(J, Acc2) ->
                                    if J > N -> Acc2;
                                       true ->
                                            Num = list_to_integer(string:substr(S, I+1, J-I)),
                                            if Num > K -> Acc2;
                                               true ->
                                                    Acc3 = array:set(J, (array:get(J, Acc2) + array:get(I, Acc)) rem 1000000007, Acc2),
                                                    Acc3
                                            end
                                    end
                                end, Acc, lists:seq(I+1, min(I+10, N)))
                        end
                end
        end
    end, DP1, lists:seq(0, N-1)),
    array:get(N, DP1).

list_to_integer(List) ->
    list_to_integer(List, 0).

list_to_integer([], Acc) ->
    Acc;
list_to_integer([H|T], Acc) ->
    list_to_integer(T, Acc * 10 + (H - $0)).