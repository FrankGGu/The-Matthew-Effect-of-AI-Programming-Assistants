-module(solution).
-export([min_changes/1]).

-spec min_changes(S :: unicode:unicode_binary() | unicode:unicode_list()) -> integer().
min_changes(S) ->
    CharList = unicode:characters_to_list(S),
    count_changes(CharList, 0).

count_changes(List, Acc) ->
    case List of
        [C0, C1, C2 | Rest] ->
            Changes = 0,
            Changes1 = if C0 =:= $0 -> Changes; true -> Changes + 1 end,
            Changes2 = if C1 =:= $1 -> Changes1; true -> Changes1 + 1 end,
            Changes3 = if C2 =:= $0 -> Changes2; true -> Changes2 + 1 end,
            count_changes(Rest, Acc + Changes3);
        _ ->
            Acc
    end.