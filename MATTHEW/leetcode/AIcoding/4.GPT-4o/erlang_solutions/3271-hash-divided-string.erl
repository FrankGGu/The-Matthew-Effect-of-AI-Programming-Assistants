-module(solution).
-export([hash_divided_string/1]).

hash_divided_string(Str) ->
    Hash = lists:foldl(fun(C, Acc) -> Acc + integer(C) end, 0, string:to_list(Str)),
    if 
        Hash rem 2 == 0 -> "Yes";
        true -> "No"
    end.