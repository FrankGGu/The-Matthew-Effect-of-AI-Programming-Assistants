-module(group_anagrams).
-export([groupAnagrams/1]).

groupAnagrams(Strs) ->
    lists:foldl(
        fun(Str, Acc) ->
            SortedStr = lists:sort(Str),
            case lists:keyfind(SortedStr, 1, Acc) of
                false ->
                    [{SortedStr, [Str]} | Acc];
                {SortedStr, Group} ->
                    lists:keyreplace(SortedStr, 1, Acc, {SortedStr, [Str | Group]})
            end
        end,
        [],
        Strs
    )
    |> lists:map(fun({_, Group}) -> Group end).