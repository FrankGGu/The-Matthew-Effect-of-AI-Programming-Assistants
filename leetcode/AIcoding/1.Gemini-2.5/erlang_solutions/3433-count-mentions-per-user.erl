-module(solution).
-export([count_mentions/1]).

count_mentions(Mentions) ->
    lists:foldl(
        fun(User, AccMap) ->
            maps:update_with(User, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        Mentions
    ).