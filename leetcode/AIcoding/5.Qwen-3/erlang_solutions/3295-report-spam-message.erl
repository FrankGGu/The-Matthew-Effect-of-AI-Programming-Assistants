-module(report_spam_message).
-export([report_spam/1]).

report_spam(Message) ->
    Words = string:split(Message, " "),
    WordCount = lists:foldl(fun(W, Acc) -> 
        case lists:keymember(W, 1, Acc) of
            true -> 
                [{W, C} | _] = lists:keytake(W, 1, Acc),
                [{W, C + 1} | lists:keydelete(W, 1, Acc)];
            false -> 
                [{W, 1} | Acc]
        end
    end, [], Words),
    lists:member("mail", Words) andalso lists:member("buy", Words) andalso lists:member("cheap", Words) andalso lists:member("click", Words) andalso lists:member("free", Words) andalso lists:member("offer", Words) andalso lists:member("price", Words) andalso lists:member("shop", Words) andalso lists:member("store", Words) andalso lists:member("url", Words).