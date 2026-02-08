-module(minimum_operations).
-export([min_operations/2]).

min_operations(Sequence, Target) ->
    Map = maps:from_list([{Val, Index} || {Index, Val} <- lists:enumerate(Sequence)]),
    List = lists:reverse(lists:seq(0, length(Target) - 1)),
    LCS(List, Target, Map, []).

LCS([], _, _, Acc) ->
    length(Acc);
LCS([I | Rest], Target, Map, Acc) ->
    Val = lists:nth(I + 1, Target),
    case maps:find(Val, Map) of
        {ok, Pos} ->
            LCS(Rest, Target, Map, [Pos | Acc]);
        _ ->
            LCS(Rest, Target, Map, Acc)
    end.