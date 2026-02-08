-spec longest_ideal_string(S :: unicode:unicode_binary(), K :: integer()) -> integer().
longest_ideal_string(S, K) ->
    List = unicode:characters_to_list(S),
    DP = lists:foldl(fun(Char, Acc) ->
        Max = lists:max([maps:get(Prev, Acc, 0) || Prev <- lists:seq(max(97, Char - K), min(122, Char + K)]),
        maps:put(Char, Max + 1, Acc)
    end, #{}, List),
    lists:max(maps:values(DP)).