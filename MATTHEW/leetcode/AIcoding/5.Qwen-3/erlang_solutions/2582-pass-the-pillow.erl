-module(pass_the_pillow).
-export([pass_the_pillow/2]).

pass_the_pillow(N, time) ->
    pass_the_pillow(N, time, 1, 1).

pass_the_pillow(_, 0, _, Result) ->
    Result;
pass_the_pillow(N, Time, Step, Result) ->
    case Step of
        1 ->
            pass_the_pillow(N, Time - 1, 2, 1);
        _ when Step == N ->
            pass_the_pillow(N, Time - 1, N - 1, N);
        _ ->
            if
                (Step > 1) and (Step < N) ->
                    if
                        (Time rem 2) == 0 ->
                            pass_the_pillow(N, Time - 1, Step + 1, Step + 1);
                        true ->
                            pass_the_pillow(N, Time - 1, Step - 1, Step - 1)
                    end
            end
    end.