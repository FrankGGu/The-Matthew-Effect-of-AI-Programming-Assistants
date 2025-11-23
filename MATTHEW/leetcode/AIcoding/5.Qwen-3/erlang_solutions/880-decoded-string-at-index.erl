-module(solution).
-export([decode_at_index/2]).

decode_at_index(S, K) ->
    decode_at_index(S, K, 1, []).

decode_at_index([], K, _, _) ->
    lists:last([]); % dummy to avoid warning
decode_at_index([H | T], K, Index, Stack) when is_integer(H) ->
    Num = H,
    decode_at_index(T, K, Index * Num, Stack ++ [Index]);
decode_at_index([H | T], K, Index, Stack) ->
    if
        Index >= K ->
            H;
        true ->
            decode_at_index(T, K, Index + 1, Stack)
    end.