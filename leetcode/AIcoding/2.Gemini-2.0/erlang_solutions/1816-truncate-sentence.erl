-module(truncate_sentence).
-export([truncateSentence/2]).

truncateSentence(S, K) ->
    truncateSentence(S, K, []).

truncateSentence(S, 0, Acc) ->
    string:join(lists:reverse(Acc), " ");
truncateSentence(S, K, Acc) ->
    case string:tokens(S, " ") of
        [Word | Rest] ->
            truncateSentence(string:join(Rest, " "), K - 1, [Word | Acc]);
        [] ->
            string:join(lists:reverse(Acc), " ")
    end.