-module(longest_common_prefix).
-export([longest_common_prefix/1]).

longest_common_prefix([]) -> "";
longest_common_prefix([H | T]) ->
    lists:foldl(fun(Str, Acc) -> common_prefix(Str, Acc) end, H, T).

common_prefix([], _) -> [];
common_prefix(_, []) -> [];
common_prefix([A | T1], [B | T2]) when A == B -> [A | common_prefix(T1, T2)];
common_prefix(_, _) -> [].