-module(solution).
-export([longestPushTime/1]).

longestPushTime(PushTimes) ->
    lists:max(PushTimes).