-module(neighboring_bitwise_xor).
-export([neighboring_bitwise_xor/1]).

neighboring_bitwise_xor(encoded) ->
    N = length(encoded),
    case N of
        0 -> [];
        1 -> encoded;
        _ ->
            lists:foldl(fun(E, Acc) ->
                                  [hd(Acc) bxor E | Acc]
                          end, [hd(encoded)], tl(encoded))
    end.