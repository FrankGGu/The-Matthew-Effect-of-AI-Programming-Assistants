-module(k_beauty).
-export([k_beauty/2]).

k_beauty(Number, K) ->
    Str = integer_to_list(Number),
    Len = length(Str),
    if
        K > Len -> 0;
        true ->
            lists:foldl(fun(I, Acc) ->
                                Sub = lists:sublist(Str, I, K),
                                Num = list_to_integer(Sub),
                                case Number rem Num of
                                    0 -> Acc + 1;
                                    _ -> Acc
                                end
                        end, 0, lists:seq(1, Len - K + 1))
    end.