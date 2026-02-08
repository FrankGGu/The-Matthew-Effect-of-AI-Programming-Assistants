-module(solution).
-export([maxEqualFreq/1]).

maxEqualFreq(List) ->
    Freqs = lists:foldl(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> maps:update(X, fun(Y) -> Y + 1 end, Acc);
            false -> maps:put(X, 1, Acc)
        end
    end, #{}, List),
    FreqList = maps:fold(fun(_, V, Acc) -> [V | Acc] end, [], Freqs),
    Counts = lists:foldl(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> maps:update(X, fun(Y) -> Y + 1 end, Acc);
            false -> maps:put(X, 1, Acc)
        end
    end, #{}, FreqList),
    case maps:size(Counts) of
        1 -> lists:length(List);
        2 -> 
            case maps:to_list(Counts) of
                [{K1, V1}, {K2, V2}] when K1 == 1 -> 
                    lists:length(List);
                [{K1, V1}, {K2, V2}] when V2 == 1 -> 
                    lists:length(List) - 1;
                [{K1, V1}, {K2, V2}] when K2 - K1 == 1, V2 == 1 -> 
                    lists:length(List) - 1;
                _ -> 
                    lists:length(List) - 2
            end;
        _ -> 
            lists:length(List) - 2
    end.