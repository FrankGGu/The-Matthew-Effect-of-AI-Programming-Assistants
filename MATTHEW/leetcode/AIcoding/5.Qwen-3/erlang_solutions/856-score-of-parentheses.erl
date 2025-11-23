-module(score_of_parentheses).
-export([score/1]).

score(S) -> score(S, 0, []).

score([], _, [Score | _]) -> Score;
score([$() | T], Depth, Stack) -> score(T, Depth + 1, [0 | Stack]);
score([$)] | T], Depth, [Top | Stack]) ->
    if
        Depth == 1 -> score(T, 0, [Top + 1 | Stack]);
        true -> score(T, Depth - 1, [Top + 1 | Stack])
    end;
score([_ | T], Depth, Stack) -> score(T, Depth, Stack).