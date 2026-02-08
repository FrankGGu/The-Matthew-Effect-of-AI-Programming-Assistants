-module(minimum_number_of_pushes_to_type_word_ii).
-export([minimumPushes/1]).

minimumPushes(Word) ->
    Count = lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Word),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, dict:to_list(Count)),
    Pushes = lists:seq(1, 10),
    lists:foldl(fun({Char, C}, {Index, Result}) ->
        case Index rem 8 of
            0 -> {Index + 1, Result + C * 10};
            _ -> {Index + 1, Result + C * (Index rem 8)}
        end
    end, {1, 0}, Sorted).