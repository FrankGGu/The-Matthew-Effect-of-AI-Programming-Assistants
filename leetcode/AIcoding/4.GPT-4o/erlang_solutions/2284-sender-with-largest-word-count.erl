-module(solution).
-export([largest_word_count/1]).

largest_word_count(M) ->
    SenderCounts = lists:foldl(fun({Sender, Message}, Acc) ->
        Words = length(string:tokens(Message, " ")),
        case maps:find(Sender, Acc) of
            {ok, Count} -> maps:update(Sender, Count + Words, Acc);
            _ -> maps:put(Sender, Words, Acc)
        end
    end, #{} , M),
    lists:max(fun({_, Count}) -> Count end, maps:to_list(SenderCounts)).