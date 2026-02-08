-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    num_ways(N, K, 0, 1, dict:new()).

num_ways(N, K, Step, Person, Memo) when Step == K ->
    1;
num_ways(N, K, Step, Person, Memo) ->
    case dict:is_key({Step, Person}, Memo) of
        true ->
            dict:fetch({Step, Person}, Memo);
        false ->
            Total = lists:foldl(
                fun(P, Acc) ->
                    if P /= Person -> Acc + num_ways(N, K, Step + 1, P, Memo);
                       true -> Acc
                    end
                end,
                0,
                lists:seq(1, N)
            ),
            NewMemo = dict:store({Step, Person}, Total, Memo),
            Total
    end.