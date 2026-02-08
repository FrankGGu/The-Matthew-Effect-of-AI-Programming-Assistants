-module(solution).
-export([maxProduct/1]).

-spec maxProduct(Words :: [string()]) -> integer().
maxProduct(Words) ->
    MaskedWords = lists:map(fun(Word) ->
                                    Mask = lists:foldl(fun(Char, Acc) -> Acc bor (1 bsl (Char - $a)) end, 0, Word),
                                    {Mask, length(Word)}
                            end, Words),
    find_max_product(MaskedWords, 0).

find_max_product([], Max) -> Max;
find_max_product([{M1, L1} | Rest], CurrentMax) ->
    NewMax = lists:foldl(fun({M2, L2}, Acc) ->
                                 if (M1 band M2) == 0 ->
                                        max(Acc, L1 * L2);
                                    true ->
                                        Acc
                                 end
                         end, CurrentMax, Rest),
    find_max_product(Rest, NewMax).