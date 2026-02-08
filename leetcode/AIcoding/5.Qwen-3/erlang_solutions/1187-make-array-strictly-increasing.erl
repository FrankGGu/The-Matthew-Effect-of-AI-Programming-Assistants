-module(solution).
-export([after_replacement/1]).

after_replacement(Values) ->
    after_replacement(Values, 0, 0, []).

after_replacement([], _, _, Result) ->
    lists:reverse(Result);
after_replacement([H | T], Prev, Count, Result) ->
    if
        H > Prev ->
            after_replacement(T, H, Count, [H | Result]);
        true ->
            NewCount = Count + 1,
            after_replacement(T, H + 1, NewCount, [H + 1 | Result])
    end.