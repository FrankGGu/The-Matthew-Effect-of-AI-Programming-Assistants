-module(solution).
-export([isAlienSorted/2]).

isAlienSorted(Words, Order) ->
    OrderMap = maps:from_list([{List, Index} || {Index, List} <- lists:zip(lists:seq(0, length(Order) - 1), string:to_list(Order))]),
    case lists:foldl(fun(Word, {Prev, true}) ->
                            case compare_words(Word, Prev, OrderMap) of
                                {less, _} -> {Word, false};
                                {equal, _} -> {Word, true};
                                {greater, _} -> {Word, true}
                            end
                    end, {hd(Words), true}, tl(Words}) of
        {_, Result} -> Result
    end.

compare_words([], [] , _) -> {equal, []};
compare_words([], _ , _) -> {less, []};
compare_words(_ , [] , _) -> {greater, []};
compare_words([H1 | T1], [H2 | T2], OrderMap) ->
    case maps:get(H1, OrderMap) <=> maps:get(H2, OrderMap) of
        equal -> compare_words(T1, T2, OrderMap);
        Result -> {Result, [H1 | T1]}
    end.