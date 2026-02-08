-module(solution).
-export([longest_common_prefix/1]).

longest_common_prefix([]) -> [];
longest_common_prefix([[] | _]) -> [];
longest_common_prefix([H | T]) ->
    Prefix = H,
    lists:foldl(fun(Str, Acc) ->
                        lists:take(min(length(Acc), length(Str)), lists:zipwith(fun(A, B) -> if A == B -> A; true -> $0 end end, Acc, Str))
                end, Prefix, T).