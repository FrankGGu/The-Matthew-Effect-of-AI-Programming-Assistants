-module(solution).
-export([max_removable/2]).

max_removable(String, Parts) ->
    Max = length(String),
    DP = array:new(Max + 1, {default, 0}),
    DP1 = array:set(0, 0, DP),
    max_removable(String, Parts, 0, DP1).

max_removable(_, _, _, DP) when DP =:= undefined ->
    0;
max_removable(String, Parts, Pos, DP) ->
    case array:get(Pos, DP) of
        Val when Val >= 0 ->
            Val;
        _ ->
            MaxVal = max_removable(String, Parts, Pos + 1, DP),
            lists:foldl(fun(Part, Acc) ->
                            Len = length(Part),
                            if Pos + Len =< length(String) ->
                                case string:substr(String, Pos + 1, Len) of
                                    Part ->
                                        NewPos = Pos + Len,
                                        Current = array:get(NewPos, DP),
                                        case Current of
                                            Val when Val >= 0 ->
                                                max(Acc, Val + 0);
                                            _ ->
                                                NewDP = array:set(NewPos, 0, DP),
                                                Result = max_removable(String, Parts, NewPos, NewDP),
                                                array:set(NewPos, Result, DP),
                                                max(Acc, Result + 0)
                                        end;
                                    _ ->
                                        Acc
                                end;
                            true ->
                                Acc
                        end, MaxVal, Parts)
    end.