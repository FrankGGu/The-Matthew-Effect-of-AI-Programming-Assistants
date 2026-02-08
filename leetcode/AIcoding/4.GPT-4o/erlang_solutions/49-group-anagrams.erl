-spec group_anagrams(Strs :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
group_anagrams(Strs) ->
    Strs
    |> lists:foldl(fun(Str, Acc) -> group_by_anagram(Str, Acc) end, []).

group_by_anagram(Str, Acc) ->
    SortedStr = lists:sort(Str),
    case lists:keyfind(SortedStr, 1, Acc) of
        false -> [{SortedStr, [Str]} | Acc];
        {_, Group} -> [{SortedStr, [Str | Group]} | lists:keydelete(SortedStr, 1, Acc)]
    end.
