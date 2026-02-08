-module(solution).
-export([odd_string_difference/1]).

odd_string_difference(Strs) ->
    UniqueDifferences = lists:usort(lists:map(fun diff/1, Strs)),
    case lists:sum(lists:map(fun (X) -> if lists:member(X, UniqueDifferences) -> 1; true -> 0 end end, Strs)) of
        1 -> lists:filter(fun (X) -> lists:member(diff(X), UniqueDifferences) end, Strs);
        _ -> []
    end.

diff(Str) ->
    lists:map(fun {A, B} -> B - A end, lists:zip(lists:seq(1, length(Str) - 1), lists:sublist(Str, 2))).