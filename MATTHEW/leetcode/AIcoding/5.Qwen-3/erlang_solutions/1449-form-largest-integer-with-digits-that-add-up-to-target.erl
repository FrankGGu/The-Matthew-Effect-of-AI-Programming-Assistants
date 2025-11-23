-module(solution).
-export([largest_number/2]).

largest_number(Digits, Target) ->
    MaxLen = length(Digits),
    DP = array:new([{size, MaxLen + 1}, {default, []}]),
    DP1 = array:set(0, [0], DP),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if J >= I -> 
                case array:get(J - I, DP1) of
                    [] -> ok;
                    Val -> 
                        NewVal = [I | Val],
                        if length(NewVal) > length(array:get(J, DP1)) -> 
                            DP2 = array:set(J, NewVal, DP1),
                            DP1 = DP2;
                        true -> ok
                        end
                end;
            true -> ok
        end
    end, lists:seq(0, Target)), 
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if J >= I -> 
                case array:get(J - I, DP1) of
                    [] -> ok;
                    Val -> 
                        NewVal = [I | Val],
                        if length(NewVal) > length(array:get(J, DP1)) -> 
                            DP2 = array:set(J, NewVal, DP1),
                            DP1 = DP2;
                        true -> ok
                        end
                end;
            true -> ok
        end
    end, lists:seq(0, Target)), 
    Result = array:get(Target, DP1),
    case Result of
        [] -> "";
        _ -> lists:reverse(Result)
    end.