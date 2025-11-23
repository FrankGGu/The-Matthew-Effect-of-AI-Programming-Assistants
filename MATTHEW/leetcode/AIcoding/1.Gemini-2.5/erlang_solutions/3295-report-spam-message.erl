-module(solution).
-export([report_spam_message/2]).

report_spam_message(Messages, SpamKeywords) ->
    lists:map(fun(Message) ->
                  is_spam(Message, SpamKeywords)
              end, Messages).

is_spam(Message, SpamKeywords) ->
    lists:any(fun(Keyword) ->
                  string:str(Message, Keyword) /= 0
              end, SpamKeywords).