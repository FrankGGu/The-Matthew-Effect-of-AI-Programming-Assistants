-module(odd_string_difference).
-export([oddString/1]).

oddString(Words) ->
    Map = lists:foldl(fun(W, Acc) ->
        Key = lists:foldl(fun(C, Acc2) -> Acc2 + (C - hd(W)) end, 0, W),
        maps:update_with(Key, fun(V) -> [W | V] end, [W], Acc)
    end, #{}, Words),
    lists:foldl(fun({_K, [W]}, Acc) ->
        case length(Acc) of
            0 -> [W];
            _ -> Acc
        end
    end, [], maps:to_list(Map)).