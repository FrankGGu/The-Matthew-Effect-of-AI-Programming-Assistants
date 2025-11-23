-module(race_car).
-export([run/1]).

run(N) ->
    run(N, 0, 0, 1, 1, dict:new()).

run(N, Pos, Steps, Speed, Dir, Memo) ->
    Key = {Pos, Speed},
    case dict:is_key(Key, Memo) of
        true -> dict:fetch(Key, Memo);
        false ->
            if
                Pos == N -> Steps;
                true ->
                    NewSteps = case Dir of
                        1 -> run(N, Pos + Speed, Steps + 1, Speed * 2, 1, Memo);
                        -1 -> run(N, Pos + Speed, Steps + 1, Speed * 2, -1, Memo)
                    end,
                    if
                        Pos + Speed > N ->
                            run(N, Pos, Steps + 1, 1, -1, dict:store(Key, NewSteps, Memo));
                        true ->
                            run(N, Pos, Steps + 1, 1, -1, dict:store(Key, NewSteps, Memo))
                    end
            end
    end.