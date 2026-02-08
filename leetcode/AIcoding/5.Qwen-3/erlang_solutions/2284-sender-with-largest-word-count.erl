-module(sender_with_largest_word_count).
-export([largest_word_count/1]).

largest_word_count(Emails) ->
    CountMap = lists:foldl(fun(Email, Acc) ->
        Words = string:split(Email, " "),
        WordCount = length(Words),
        Key = Email,
        maps:update(Key, WordCount, Acc)
    end, #{}, Emails),
    {Sender, MaxCount} = lists:foldl(fun({Key, Val}, {CurrentSender, CurrentMax}) ->
        if Val > CurrentMax -> {Key, Val};
           true -> {CurrentSender, CurrentMax}
        end
    end, {"", 0}, maps:to_list(CountMap)),
    Sender.