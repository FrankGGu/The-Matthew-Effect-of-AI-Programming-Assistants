-module(minimum_number_of_operations_to_make_word_k_periodic).
-export([minOperations/3]).

minOperations(Word, k, p) ->
    Len = length(Word),
    SubLen = k * p,
    Count = lists:foldl(fun(I, Acc) ->
        Sub = lists:sublist(Word, I, k),
        case lists:all(fun(J) -> lists:sublist(Word, J, k) == Sub end, lists:seq(I + k, Len - k + 1, k)) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(1, Len - k + 1, k)),
    (Len - SubLen) - Count * k.