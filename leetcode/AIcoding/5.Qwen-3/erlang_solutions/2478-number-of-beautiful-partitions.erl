-module(number_of_beautiful_partitions).
-export([num_beautiful_partitions/2]).

num_beautiful_partitions(S, K) ->
    N = length(S),
    if
        K > N -> 0;
        true ->
            DP = array:new(N + 1, {default, 0}),
            array:set(0, 1, DP),
            IsVowel = fun(C) -> lists:member(C, [$a, $e, $i, $o, $u]) end,
            IsConsonant = fun(C) -> not IsVowel(C) end,
            lists:foldl(fun(I, Acc) ->
                lists:foldl(fun(J, Acc2) ->
                    if
                        J >= I -> Acc2;
                        true ->
                            case (IsVowel(string:at(S, J)) andalso IsConsonant(string:at(S, I))) of
                                true ->
                                    Val = array:get(J, Acc2),
                                    NewVal = Val + array:get(I, Acc2),
                                    array:set(I, NewVal, Acc2);
                                false ->
                                    Acc2
                            end
                    end
                end, Acc, lists:seq(0, I - 1))
            end, DP, lists:seq(1, N)),
            array:get(N, DP)
    end.