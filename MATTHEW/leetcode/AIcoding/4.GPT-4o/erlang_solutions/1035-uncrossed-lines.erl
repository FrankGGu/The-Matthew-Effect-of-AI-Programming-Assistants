-module(solution).
-export([max_uncrossed_lines/2]).

max_uncrossed_lines(A, B) ->
    max_uncrossed_lines_helper(A, B, length(A), length(B), []).

max_uncrossed_lines_helper(_, _, 0, _, Acc) ->
    Acc;
max_uncrossed_lines_helper(_, _, _, 0, Acc) ->
    Acc;
max_uncrossed_lines_helper(A, B, I, J, Acc) ->
    if
        lists:nth(I, A) =:= lists:nth(J, B) ->
            max_uncrossed_lines_helper(A, B, I - 1, J - 1, Acc + 1);
        true ->
            max_uncrossed_lines_helper(A, B, I - 1, J, Acc) orelse
            max_uncrossed_lines_helper(A, B, I, J - 1, Acc)
    end.