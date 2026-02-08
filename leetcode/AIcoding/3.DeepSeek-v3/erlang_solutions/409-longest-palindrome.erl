-spec longest_palindrome(S :: unicode:unicode_binary()) -> integer().
longest_palindrome(S) ->
    CharCounts = lists:foldl(fun(Char, Acc) ->
                                maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                             end, #{}, unicode:characters_to_list(S)),
    {Sum, HasOdd} = maps:fold(fun(_, V, {Acc, Odd}) ->
                                 case V rem 2 of
                                     0 -> {Acc + V, Odd};
                                     1 -> {Acc + V - 1, true}
                                 end
                              end, {0, false}, CharCounts),
    Sum + case HasOdd of true -> 1; false -> 0 end.