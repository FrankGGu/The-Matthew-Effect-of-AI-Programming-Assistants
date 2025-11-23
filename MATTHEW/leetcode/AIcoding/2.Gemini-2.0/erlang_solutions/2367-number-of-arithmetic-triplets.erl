-module(arithmetic_triplets).
-export([number_of_arithmetic_triplets/2]).

number_of_arithmetic_triplets(Nums, Diff) ->
    number_of_arithmetic_triplets(Nums, Diff, 0).

number_of_arithmetic_triplets([], _, Acc) ->
    Acc;
number_of_arithmetic_triplets([Num | Rest], Diff, Acc) ->
    Count = lists:foldl(
        fun(I, Acc2) ->
            case lists:member(Num + Diff, Rest) andalso lists:member(Num + 2 * Diff, Rest) of
                true -> Acc2 + 1;
                false -> Acc2
            end
        end,
        0,
        [Num]
    ),
    number_of_arithmetic_triplets(Rest, Diff, Acc + Count).