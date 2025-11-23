-module(solution).
-export([report_spam/1]).

report_spam(Messages) ->
    lists:filter(fun(Message) -> lists:member(<<"spam">>, Message) end, Messages).