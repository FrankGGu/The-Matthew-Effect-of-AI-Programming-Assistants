-module(solution).
-export([contains_pattern/3]).

contains_pattern(S, M, K) ->
    List = string:to_list(S),
    Length = length(List),
    Pattern = lists:duplicate(M, $a),
    contains_pattern(List, Pattern, K, M, Length, 0).

contains_pattern(_, _, 0, _, _, _) -> true;
contains_pattern(List, Pattern, K, M, Length, Count) ->
    case lists:prefix(lists:sublist(List, 0, M), Pattern) of
        true ->
            contains_pattern(lists:delete_prefix(List, M), Pattern, K - 1, M, Length, Count + 1);
        false ->
            case Count >= K of
                true -> true;
                false -> contains_pattern(lists:delete_prefix(List, 1), Pattern, K, M, Length, 0)
            end
    end.

delete_prefix(List, N) ->
    lists:sublist(List, N + 1, length(List) - N).