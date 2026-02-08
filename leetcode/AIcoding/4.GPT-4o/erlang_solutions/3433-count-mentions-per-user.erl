-module(solution).
-export([count_mentions_per_user/1]).

count_mentions_per_user(Mentions) ->
    lists:foldl(fun(Mention, Acc) ->
        User = lists:nth(1, Mention),
        Count = maps:get(User, Acc, 0) + 1,
        maps:put(User, Count, Acc)
    end, maps:empty(), Mentions).