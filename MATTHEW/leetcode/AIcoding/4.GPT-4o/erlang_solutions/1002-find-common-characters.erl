-module(solution).
-export([common_chars/1]).

common_chars(List) ->
    case List of
        [] -> [];
        [H|T] -> lists:foldl(fun(Common, Acc) -> common(H, Common, Acc) end, H, T)
    end.

common(Str1, Str2, Acc) ->
    lists:foldl(fun(Char, Acc2) ->
        if
            lists:member(Char, Str2) ->
                [Char | Acc2];
            true ->
                Acc2
        end
    end, Acc, lists:usort(lists:flatmap(fun(X) -> [X] end, Str1))).