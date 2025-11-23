-spec group_anagrams(Strs :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
group_anagrams(Strs) ->
    Dict = lists:foldl(fun(Str, Acc) ->
        Key = lists:sort(binary_to_list(Str)),
        dict:append(Key, Str, Acc)
    end, dict:new(), Strs),
    dict:fold(fun(_, Vals, Acc) -> [Vals | Acc] end, [], Dict).