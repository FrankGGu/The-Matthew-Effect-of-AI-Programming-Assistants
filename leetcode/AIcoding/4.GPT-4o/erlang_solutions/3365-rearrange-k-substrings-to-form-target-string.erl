-module(solution).
-export([can_rearrange/3]).

can_rearrange(S, K, Target) ->
    SList = string:to_list(S),
    TargetList = string:to_list(Target),
    length(SList) rem K =:= 0 andalso 
    lists:all(fun(L) -> lists:member(L, [SList, TargetList]) end, [SList, TargetList]).