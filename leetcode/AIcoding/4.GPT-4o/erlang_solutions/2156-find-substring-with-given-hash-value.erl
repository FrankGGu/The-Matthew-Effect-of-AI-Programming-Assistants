-module(solution).
-export([sub_str_with_hash_value/3]).

sub_str_with_hash_value(S, H, L) ->
    N = length(S),
    Hash = fun(Str) -> 
        lists:foldl(fun(Char, Acc) -> (Acc * 31 + Char) rem (10^9 + 7) end, 0, Str)
    end,
    case find_substring(S, H, L, N, Hash) of
        [] -> -1;
        SubStr -> SubStr
    end.

find_substring(_, _, _, N, _) when N < 0 -> [];
find_substring(S, H, L, N, Hash) ->
    case lists:sublist(S, N - L + 1, L) of
        Sub when Hash(Sub) =:= H -> Sub;
        _ -> find_substring(S, H, L, N - 1, Hash)
    end.