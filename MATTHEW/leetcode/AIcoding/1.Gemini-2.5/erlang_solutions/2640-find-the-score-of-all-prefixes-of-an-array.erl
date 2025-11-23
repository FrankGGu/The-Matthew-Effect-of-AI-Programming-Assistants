-module(solution).
-export([find_score/1]).

find_score([]) -> [];
find_score(Nums) ->
    find_score_recursive(Nums, 0, 0, []).

find_score_recursive([], _CurrentSum, _CurrentMax, Acc) ->
    lists:reverse(Acc);
find_score_recursive([H|T], CurrentSum, CurrentMax, Acc) ->
    NewSum = CurrentSum + H,
    NewMax = max(CurrentMax, H),
    Score = NewSum + NewMax,
    find_score_recursive(T, NewSum, NewMax, [Score|Acc]).