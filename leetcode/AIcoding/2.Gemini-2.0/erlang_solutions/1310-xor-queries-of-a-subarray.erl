-module(xor_queries).
-export([xor_queries/2]).

xor_queries(Arr, Queries) ->
    PrefixXor = prefix_xor(Arr),
    lists:map(fun(Query) ->
                      [L, R] = Query,
                      case L of
                          0 -> lists:nth(R + 1, PrefixXor);
                          _ -> lists:nth(L, PrefixXor) bxor lists:nth(R + 1, PrefixXor)
                      end
              end, Queries).

prefix_xor(Arr) ->
    prefix_xor_helper(Arr, [], 0).

prefix_xor_helper([], Acc, _) ->
    lists:reverse(Acc);
prefix_xor_helper([H|T], Acc, Xor) ->
    NewXor = Xor bxor H,
    prefix_xor_helper(T, [NewXor|Acc], NewXor).