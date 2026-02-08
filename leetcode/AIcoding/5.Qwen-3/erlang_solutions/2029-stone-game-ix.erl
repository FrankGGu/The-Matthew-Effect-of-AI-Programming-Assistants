-module(stone_game_ix).
-export([ok/1]).

ok(Stones) ->
    Counts = lists:foldl(fun(X, Acc) -> dict:update_counter(X rem 3, 1, Acc) end, dict:new(), Stones),
    A = dict:fetch(1, Counts, 0),
    B = dict:fetch(2, Counts, 0),
    C = dict:fetch(0, Counts, 0),
    if
        A == 0 andalso B == 0 -> true;
        A == 0 -> (B > 0) andalso (C > 0);
        B == 0 -> (A > 0) andalso (C > 0);
        true -> (A > B) andalso (B > 0) andalso (C > 0)
    end.