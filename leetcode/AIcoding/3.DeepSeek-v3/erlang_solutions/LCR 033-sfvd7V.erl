-spec group_anagrams(Strs :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
group_anagrams(Strs) ->
    Dict = lists:foldl(fun(Str, Acc) ->
        Sorted = lists:sort(unicode:characters_to_list(Str)),
        Key = unicode:characters_to_binary(Sorted),
        maps:update_with(Key, fun(Group) -> [Str | Group] end, [Str], Acc)
    end, #{}, Strs),
    maps:values(Dict).