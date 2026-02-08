-module(solution).
-export([kth_lexicographical/2]).

kth_lexicographical(N, K) ->
    generate_all(0, N, [], []).

generate_all(_, 0, Current, Acc) ->
    lists:reverse([lists:reverse(Current) | Acc]);
generate_all(Index, Length, Current, Acc) ->
    generate_all(Index + 1, Length - 1, [$(a + Index) | Current], Acc),
    generate_all(Index + 1, Length - 1, [$(b + Index) | Current], Acc),
    generate_all(Index + 1, Length - 1, [$(c + Index) | Current], Acc).

kth_lexicographical(N, K) ->
    All = generate_all(0, N, [], []),
    lists:nth(K, All).