-module(solution).
-export([all_possible_fbt/1]).

all_possible_fbt(N) ->
    all_possible_fbt(N, dict:new()).

all_possible_fbt(0, _) ->
    [[]];
all_possible_fbt(1, _) ->
    [[[]]];
all_possible_fbt(N, Cache) ->
    case dict:is_key(N, Cache) of
        true ->
            dict:fetch(N, Cache);
        false ->
            Lists = lists:flatmap(fun(I) ->
                Lefts = all_possible_fbt(I, Cache),
                Rights = all_possible_fbt(N - 1 - I, Cache),
                lists:flatmap(fun(L) ->
                    lists:flatmap(fun(R) ->
                        [[{node, L, R} | []] | []]
                    end, Rights)
                end, Lefts)
            end, lists:seq(0, N-1)),
            NewCache = dict:store(N, Lists, Cache),
            Lists
    end.