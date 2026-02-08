-module(solution).
-export([largest_word_count/2]).

-include_lib("kernel/include/string.hrl").

largest_word_count(Messages, Senders) ->
    % Step 1: Pair messages with senders and calculate word counts for each message
    % This creates a list of {WordCount, Sender} tuples
    WordCountsPerMessageSender = lists:zipwith(
        fun(Message, Sender) ->
            WordCount = length(string:tokens(Message, " ")),
            {WordCount, Sender}
        end,
        Messages,
        Senders
    ),

    % Step 2: Aggregate word counts per sender into a map
    % The map will be of the form #{Sender => TotalWordCount}
    SenderTotalWordCounts = lists:foldl(
        fun({WordCount, Sender}, AccMap) ->
            maps:update_with(Sender, fun(OldCount) -> OldCount + WordCount end, WordCount, AccMap)
        end,
        maps:new(),
        WordCountsPerMessageSender
    ),

    % Step 3: Find the sender with the maximum total word count
    % Handle ties by choosing the lexicographically largest sender
    % The accumulator is {MaxCount, BestSender}
    {_MaxCount, BestSender} = lists:foldl(
        fun({Sender, Count}, {CurrentMaxCount, CurrentBestSender}) ->
            if
                Count > CurrentMaxCount ->
                    {Count, Sender};
                Count == CurrentMaxCount ->
                    % Tie: choose lexicographically largest sender
                    if
                        Sender > CurrentBestSender ->
                            {Count, Sender};
                        true ->
                            {CurrentMaxCount, CurrentBestSender}
                    end;
                true ->
                    {CurrentMaxCount, CurrentBestSender}
            end
        end,
        {0, ""}, % Initial state: 0 words, empty string sender (lexicographically smallest)
        maps:to_list(SenderTotalWordCounts)
    ),

    BestSender.