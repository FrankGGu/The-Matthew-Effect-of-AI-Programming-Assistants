-module(maximum_product_word_lengths).
-export([max_product/1]).

max_product(Words) ->
    Bitmasks = [list_to_integer([case lists:member(C, "abcdefghijklmnopqrstuvwxyz") of true -> 1; false -> 0 end || C <- integer_to_list($a + (ord(W) - $a))]) || W <- lists:usort(lists:concat(string:to_lower(string:characters(Word, latin1)))) || Word <- Words],

    max_product_helper(Bitmasks, Words, 0).

max_product_helper([], [], MaxProd) ->
    MaxProd;
max_product_helper([H | T], [Word | Words], MaxProd) ->
    NewMaxProd = lists:foldl(fun(OtherBitmask, AccMaxProd) ->
                                    case H band OtherBitmask == 0 of
                                        true ->
                                            OtherWord = lists:nth(lists:nth(1, lists:keyfind(OtherBitmask, 1, lists:zip(lists:nth(1, lists:zip(lists:seq(1, length(T))), T), lists:nth(1, lists:zip(lists:nth(1, lists:zip(lists:seq(1, length(Words))), Words))))), 2)),
                                            max(AccMaxProd, length(Word) * length(OtherWord));
                                        false ->
                                            AccMaxProd
                                    end
                                end,
                                MaxProd,
                                T),
    max_product_helper(T, lists:nthtail(1, Words), NewMaxProd).