-module(reshape_data_melt).
-export([melt/1]).

melt(Data) ->
    melt(Data, []).

melt([], Result) ->
    lists:reverse(Result);
melt([[Id|Values]|Rest], Result) ->
    melt(Rest, lists:foldl(fun {Var, Val}, Acc -> [{Id, Var, Val}|Acc] end, Result, lists:zip(lists:seq(1, length(Values)), Values))).