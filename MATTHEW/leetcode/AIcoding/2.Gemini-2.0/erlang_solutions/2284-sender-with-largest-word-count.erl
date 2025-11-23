-module(sender_with_largest_word_count).
-export([largest_word_count/2]).

largest_word_count(Messages, Senders) ->
    WordCounts = lists:zipwith(fun(M) -> length(string:tokens(M, " ")) end, Messages),
    SenderWordCounts = lists:zip(Senders, WordCounts),
    Acc = dict:new(),
    FoldFun = fun({Sender, WordCount}, AccIn) ->
        case dict:is_key(Sender, AccIn) of
            true ->
                OldCount = dict:fetch(Sender, AccIn),
                dict:store(Sender, OldCount + WordCount, AccIn);
            false ->
                dict:store(Sender, WordCount, AccIn)
        end
    end,
    AggregatedCounts = lists:foldl(FoldFun, Acc, SenderWordCounts),
    CountsList = dict:to_list(AggregatedCounts),
    MaxCount = lists:max([Count || {_, Count} <- CountsList]),
    SendersWithMaxCount = [Sender || {Sender, Count} <- CountsList, Count == MaxCount],
    lists:max(SendersWithMaxCount).