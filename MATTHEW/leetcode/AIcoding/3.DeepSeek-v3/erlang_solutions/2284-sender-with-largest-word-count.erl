-spec largest_word_count(Messages :: [unicode:unicode_binary()], Senders :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
largest_word_count(Messages, Senders) ->
    Counts = lists:foldl(fun({Msg, Sender}, Acc) ->
                            Words = binary:split(Msg, <<" ">>, [global]),
                            Count = length(Words),
                            maps:update_with(Sender, fun(V) -> V + Count end, Count, Acc)
                         end, #{}, lists:zip(Messages, Senders)),
    MaxCount = lists:max(maps:values(Counts)),
    MaxSenders = [S || {S, C} <- maps:to_list(Counts), C =:= MaxCount],
    lists:last(lists:sort(MaxSenders)).