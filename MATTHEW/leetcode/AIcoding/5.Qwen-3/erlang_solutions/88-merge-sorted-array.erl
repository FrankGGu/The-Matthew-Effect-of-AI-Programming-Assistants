-module(merge_sorted_array).
-export([merge/3]).

merge(A, M, B, N) ->
    merge(A, M, B, N, []).

merge([], _, B, N, Acc) ->
    lists:reverse(Acc ++ B);
merge(_, _, [], N, Acc) ->
    lists:reverse(Acc);
merge([AHead | ATail], M, [BHead | BTail], N, Acc) when AHead < BHead ->
    merge(ATail, M - 1, [BHead | BTail], N, [AHead | Acc]);
merge([AHead | ATail], M, [BHead | BTail], N, Acc) ->
    merge([AHead | ATail], M, BTail, N - 1, [BHead | Acc]).

merge(A, M, B, N) ->
    merge(A, M, B, N, []).