-module(solution).
-export([longest_subsequence/1]).

longest_subsequence(Sequence) ->
    Length = length(Sequence),
    longest_subsequence(Sequence, Length, 0).

longest_subsequence([], _, Max) -> Max;
longest_subsequence([H | T], Length, Max) ->
    {NewMax, NewLength} = longest_helper([H | T], H, 1, Max),
    longest_subsequence(T, Length, max(NewMax, NewLength)).

longest_helper([], _, Count, Max) -> {max(Max, Count), Count};
longest_helper([H | T], Prev, Count, Max) ->
    if
        H < Prev -> longest_helper(T, H, Count + 1, Max);
        true -> longest_helper(T, H, 1, Max)
    end.