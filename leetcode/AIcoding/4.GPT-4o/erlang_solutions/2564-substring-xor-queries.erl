-module(solution).
-export([substring_xor_queries/2]).

substring_xor_queries(S, Queries) ->
    N = length(S),
    Binary = list_to_binary(S),
    PrefixXor = lists:foldl(fun(_, Acc) -> [0 | Acc] end, [0], lists:map(fun Ch -> Ch bxor hd(Acc) end, S)),
    QueryResults = lists:map(fun {L, R} -> 
        XorValue = lists:nth(R + 1, PrefixXor) bxor lists:nth(L, PrefixXor),
        case binary_to_list(binary:part(Binary, L, R - L + 1)) of
            [] -> false;
            Bin when XorValue =:= binary_to_integer(Bin) -> true;
            _ -> false
        end
    end, Queries),
    QueryResults.

binary_to_integer(Bin) ->
    lists:foldl(fun(B, Acc) -> Acc * 2 + B end, 0, binary_to_list(Bin)).