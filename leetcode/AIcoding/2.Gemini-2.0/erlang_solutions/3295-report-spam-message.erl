-module(spam_report).
-export([report_spam/1]).

-spec report_spam(list(map())) -> list(map()).
report_spam(Messages) ->
  SpamMessages = [M || M <- Messages, maps:get(spam, M) == true],
  lists:map(fun(M) -> maps:remove(spam, M) end, SpamMessages).