-module(maximum_score_after_splitting_a_string).
-export([max_score/1]).

max_score(Str) ->
    N = erlang:length(Str),
    Left = 0,
    Right = count_ones(Str),
    Max = 0,
    loop(1, N-1, Left, Right, Max).

loop(I, N, Left, Right, Max) when I > N ->
    Max;
loop(I, N, Left, Right, Max) ->
    Current = if
        lists:nth(I, Str) == $1 -> Left + 1;
        true -> Left
    end,
    Score = (Left) + (Right - (if lists:nth(I, Str) == $1 -> 1; true -> 0 end)),
    NewMax = max(Max, Score),
    loop(I+1, N, Current, Right - (if lists:nth(I, Str) == $1 -> 1; true -> 0 end), NewMax).

count_ones([]) -> 0;
count_ones([C|T]) ->
    if C == $1 -> 1 + count_ones(T);
       true -> count_ones(T)
    end.