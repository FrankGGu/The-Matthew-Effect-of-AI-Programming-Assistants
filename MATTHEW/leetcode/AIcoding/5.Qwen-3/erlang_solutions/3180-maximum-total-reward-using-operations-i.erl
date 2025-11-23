-module(max_total_reward).
-export([max_total_reward/1]).

max_total_reward(Operations) ->
    max_total_reward(Operations, 0, 0, 1, maps:new()).

max_total_reward([], _Score, _Used, _Next, _Memo) ->
    _Score;
max_total_reward(Operations, Score, Used, Next, Memo) ->
    Key = {Used, Next},
    case maps:find(Key, Memo) of
        {ok, Val} -> Val;
        error ->
            Max = lists:max(
                [max_total_reward(
                    Operations,
                    Score + Value,
                    Used bor (1 bsl (Value - 1)),
                    Next + 1,
                    Memo
                 ) || {Value, _} <- Operations, (Used band (1 bsl (Value - 1))) == 0]
                ++ [max_total_reward(
                        Operations,
                        Score,
                        Used,
                        Next + 1,
                        Memo
                     )]
            ),
            maps:put(Key, Max, Memo),
            Max
    end.