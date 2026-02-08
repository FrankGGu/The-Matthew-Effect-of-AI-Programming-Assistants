-module(small_string).
-export([get_min_string/2]).

get_min_string(N, K) ->
    Chars = lists:seq($a, $z),
    Result = lists:duplicate(N, $a),
    get_min_string(N, K, 0, Result).

get_min_string(0, _, _, Acc) ->
    lists:reverse(Acc);
get_min_string(N, K, Index, Acc) ->
    MaxChar = min(K - N + 1, 26),
    Char = lists:nth(MaxChar, lists:seq($a, $z)),
    NewAcc = lists:sublist(Acc, Index) ++ [Char] ++ lists:sublist(Acc, Index + 1, N - Index - 1),
    get_min_string(N - 1, K - MaxChar, Index + 1, NewAcc).