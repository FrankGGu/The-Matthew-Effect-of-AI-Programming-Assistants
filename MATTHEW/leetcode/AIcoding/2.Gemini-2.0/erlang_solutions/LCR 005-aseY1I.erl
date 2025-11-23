-module(max_product).
-export([max_product/1]).

max_product(Words) ->
    SetWords = [list_to_set(list_to_lower(Word)) || Word <- Words],
    max_product_helper(SetWords, 0).

max_product_helper([], Max) ->
    Max;
max_product_helper([Word | Rest], Max) ->
    NewMax = lists:foldl(
        fun(OtherWord, Acc) ->
            case sets:is_disjoint(Word, OtherWord) of
                true ->
                    max(Acc, length(Word) * length(OtherWord));
                false ->
                    Acc
            end
        end,
        Max,
        Rest
    ),
    max_product_helper(Rest, NewMax).