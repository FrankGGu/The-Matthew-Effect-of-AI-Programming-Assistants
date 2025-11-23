-module(solution).
-export([longest_common_prefix/1]).

longest_common_prefix(Strs) ->
    case Strs of
        [] -> "";
        [H | _] -> longest_common_prefix(H, Strs, "") 
    end.

longest_common_prefix(_, [], Prefix) -> Prefix;
longest_common_prefix(Prefix, [H | T], Acc) ->
    NewPrefix = common_prefix(Prefix, H),
    if
        NewPrefix =:= "" -> "";
        true -> longest_common_prefix(NewPrefix, T, NewPrefix)
    end.

common_prefix([], _) -> [];
common_prefix(_, []) -> [];
common_prefix([H1 | T1], [H2 | T2]) when H1 =:= H2 ->
    [H1 | common_prefix(T1, T2)];
common_prefix(_, _) -> [].