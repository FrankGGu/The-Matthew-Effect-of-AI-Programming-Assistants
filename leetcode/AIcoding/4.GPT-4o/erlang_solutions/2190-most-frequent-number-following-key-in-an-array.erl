-module(solution).
-export([most_frequent/2]).

most_frequent(Key, Array) ->
    CountMap = maps:fold(fun(X, Acc) ->
        case X of
            Key -> Acc;
            _ -> maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc)
        end
    end, #{}, Array),
    case maps:is_key(Key, CountMap) of
        false -> -1;
        true -> 
            NextMap = maps:fold(fun(X, Acc) ->
                case X of
                    Key -> Acc;
                    _ -> maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc)
                end
            end, #{}, tl(Array)),
            MostFrequent = maps:to_list(NextMap),
            lists:max(MostFrequent)
    end.