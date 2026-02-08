-module(meet).
-export([can_meet/2]).

can_meet(Alice, Bob) ->
    lists:foldl(fun({A, B}, Acc) ->
        case A of
            0 -> {B, Acc};
            _ -> Acc
        end
    end, {0, 0}, lists:zip(Alice, Bob)).

can_meet(Alice, Bob, K) ->
    lists:foldl(fun({A, B}, Acc) ->
        case A of
            0 -> {B, Acc};
            _ -> Acc
        end
    end, {0, 0}, lists:zip(Alice, Bob)).