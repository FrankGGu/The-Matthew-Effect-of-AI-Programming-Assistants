-module(solution).
-export([maximize_confusion/2]).

maximize_confusion(N, answer_string) ->
    maximize_confusion(N, answer_string, 0, 0).

maximize_confusion(_, [], count, _) -> count;
maximize_confusion(N, [H | T], count, idx) when idx < N ->
    maximize_confusion(N, T, count + (if H == $T -> 1; true -> 0 end), idx + 1);
maximize_confusion(N, [H | T], count, idx) ->
    maximize_confusion(N, T, count, idx + 1).