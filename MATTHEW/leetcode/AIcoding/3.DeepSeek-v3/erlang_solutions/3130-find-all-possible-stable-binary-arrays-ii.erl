-module(solution).
-export([number_of_stable_arrays/3]).

number_of_stable_arrays(Zero, One, Limit) ->
    Mod = 1000000007,
    DP = maps:new(),
    DP1 = maps:put({0, 0, 0}, 1, DP),
    DP2 = helper(Zero, One, Limit, DP1, Mod),
    maps:fold(fun(_, V, Acc) -> (Acc + V) rem Mod end, 0, DP2).

helper(Zero, One, Limit, DP, Mod) ->
    case Zero =:= 0 andalso One =:= 0 of
        true -> DP;
        false ->
            NewDP = maps:new(),
            {UpdatedDP, _} = maps:fold(fun({Z, O, C}, Count, {AccDP, _}) ->
                NewCount = Count rem Mod,
                case Z > 0 of
                    true ->
                        case C =< 0 orelse C - 1 >= -Limit of
                            true ->
                                NewC = if C =< 0 -> -1; true -> C - 1 end,
                                Key = {Z - 1, O, NewC},
                                case maps:is_key(Key, AccDP) of
                                    true -> 
                                        Old = maps:get(Key, AccDP),
                                        NewAccDP = maps:put(Key, (Old + NewCount) rem Mod, AccDP);
                                    false ->
                                        NewAccDP = maps:put(Key, NewCount, AccDP)
                                end;
                            false ->
                                NewAccDP = AccDP
                        end;
                    false ->
                        NewAccDP = AccDP
                end,
                case O > 0 of
                    true ->
                        case C >= 0 orelse C + 1 =< Limit of
                            true ->
                                NewC = if C >= 0 -> 1; true -> C + 1 end,
                                Key = {Z, O - 1, NewC},
                                case maps:is_key(Key, NewAccDP) of
                                    true -> 
                                        Old = maps:get(Key, NewAccDP),
                                        NewAccDP2 = maps:put(Key, (Old + NewCount) rem Mod, NewAccDP);
                                    false ->
                                        NewAccDP2 = maps:put(Key, NewCount, NewAccDP)
                                end;
                            false ->
                                NewAccDP2 = NewAccDP
                        end;
                    false ->
                        NewAccDP2 = NewAccDP
                end,
                {NewAccDP2, 0}
            end, {NewDP, 0}, DP),
            helper(Zero - 1, One, Limit, UpdatedDP, Mod)
    end.