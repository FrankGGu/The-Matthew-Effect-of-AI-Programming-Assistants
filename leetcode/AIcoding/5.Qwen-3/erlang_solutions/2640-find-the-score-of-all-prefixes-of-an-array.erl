-module(solution).
-export([find_score/1]).

find_score(Nums) ->
    find_score(Nums, 0, 0, []).

find_score([], _, _, Acc) ->
    lists:reverse(Acc);
find_score([H | T], Index, Sum, Acc) ->
    NewSum = Sum + H,
    Score = NewSum * (Index + 1),
    find_score(T, Index + 1, NewSum, [Score | Acc]).