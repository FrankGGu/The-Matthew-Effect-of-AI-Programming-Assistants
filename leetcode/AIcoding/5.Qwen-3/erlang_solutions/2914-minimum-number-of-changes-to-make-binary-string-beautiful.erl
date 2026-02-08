-module(minimum_number_of_changes_to_make_binary_string_beautiful).
-export([minChanges/1]).

minChanges(Bin) ->
    N = length(Bin),
    minChanges(Bin, 0, 0, 0).

minChanges([], _, Count, _) ->
    Count;
minChanges([H | T], Index, Count, Target) ->
    Current = H - $0,
    Expected = Target rem 2,
    if
        Current == Expected ->
            minChanges(T, Index + 1, Count, Target + 1);
        true ->
            minChanges(T, Index + 1, Count + 1, Target + 1)
    end.