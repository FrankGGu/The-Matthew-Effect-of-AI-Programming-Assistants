-module(shortest_completing_word).
-export([shortest_completing_word/2]).

shortest_completing_word(Words, P) ->
    PChars = lists:usort(string:to_lower(P)),
    PCount = count_chars(P),
    lists:foldl(fun(W, Acc) ->
        WLower = string:to_lower(W),
        if
            is_completable(WLower, PCount) ->
                case Acc of
                    [] -> [W];
                    _ -> if length(W) < length(hd(Acc)) -> [W]; true -> Acc end
                end;
            true -> Acc
        end
    end, [], Words).

is_completable(W, PCount) ->
    WCount = count_chars(W),
    maps:fold(fun(K, V, Acc) ->
        case maps:get(K, WCount, 0) of
            CV when CV >= V -> Acc;
            _ -> false
        end
    end, true, PCount).

count_chars(S) ->
    lists:foldl(fun(C, Acc) ->
        maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, S).