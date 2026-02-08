-module(card_flipping_game).
-export([backtrack/1]).

backtrack(Choices) ->
    backtrack(Choices, 0, []).

backtrack([], _, Acc) ->
    lists:sum(Acc);
backtrack([H|T], Index, Acc) ->
    [Num, _] = H,
    backtrack(T, Index + 1, [Num | Acc]).

solve(Choices) ->
    backtrack(Choices).

backtrack(_, _, _) ->
    0.