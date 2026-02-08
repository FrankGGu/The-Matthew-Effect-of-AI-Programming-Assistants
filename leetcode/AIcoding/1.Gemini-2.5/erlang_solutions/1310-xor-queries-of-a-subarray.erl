-module(solution).
-export([xorQueries/2]).

xorQueries(Arr, Queries) ->
    PrefixXORList = generate_prefix_xor_list(Arr),
    PrefixXORTuple = list_to_tuple(PrefixXORList),
    lists:map(fun([L, R]) ->
                      element(R + 2, PrefixXORTuple) bxor element(L + 1, PrefixXORTuple)
              end, Queries).

generate_prefix_xor_list(Arr) ->
    generate_prefix_xor_list(Arr, [0], 0).

generate_prefix_xor_list([], Acc, _CurrentXOR) ->
    lists:reverse(Acc).
generate_prefix_xor_list([H|T], Acc, CurrentXOR) ->
    NewCurrentXOR = CurrentXOR bxor H,
    generate_prefix_xor_list(T, [NewCurrentXOR | Acc], NewCurrentXOR).