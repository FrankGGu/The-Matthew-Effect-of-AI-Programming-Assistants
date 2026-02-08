-module(top_k_frequent_words).
-export([topKFrequent/2]).

topKFrequent(Words, K) ->
    Count = count_words(Words),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Count),
    [Word || {Word, _} <- lists:sublist(Sorted, K)].

count_words(Words) ->
    count_words(Words, #{}).

count_words([], Acc) ->
    maps:to_list(Acc);
count_words([Word | Rest], Acc) ->
    NewAcc = case maps:is_key(Word, Acc) of
                 true -> maps:update(Word, maps:get(Word, Acc) + 1, Acc);
                 false -> maps:put(Word, 1, Acc)
             end,
    count_words(Rest, NewAcc).