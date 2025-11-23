-module(solution).
-export([min_valid_strings/2]).

min_valid_strings(Paths, Target) ->
    Map = lists:foldl(fun(Path, Acc) ->
        lists:foldl(fun(I, A) ->
            Key = string:substr(Path, I+1),
            maps:update(Key, 1, A)
        end, Acc, lists:seq(0, length(Path)-1))
    end, maps:new(), Paths),
    Length = length(Target),
    DP = array:new(Length + 1, {default, 0}),
    array:set(0, 1, DP),
    lists:foldl(fun(I, D) ->
        case array:get(I, D) of
            0 -> D;
            _ ->
                lists:foldl(fun(J, Acc) ->
                    Sub = string:substr(Target, I+1, J),
                    case maps:is_key(Sub, Map) of
                        true -> array:set(I+J, array:get(I+J, Acc) + array:get(I, D), Acc);
                        false -> Acc
                    end
                end, D, lists:seq(1, Length - I))
        end
    end, DP, lists:seq(0, Length - 1)),
    array:get(Length, DP).