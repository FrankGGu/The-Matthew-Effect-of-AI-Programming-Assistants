-module(solution).
-export([max_product/1]).

max_product(Paragraph) ->
    Words = string:tokens(Paragraph, " "),
    WordSets = lists:map(fun(W) -> sets:from_list(W) end, Words),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                I /= J ->
                    A = sets:to_list(WordSets:I),
                    B = sets:to_list(WordSets:J),
                    if
                        sets:intersection(WordSets:I, WordSets:J) == sets:new() ->
                            Product = length(A) * length(B),
                            if Product > Acc2 -> Product; true -> Acc2 end;
                        true -> Acc2
                    end;
                true -> Acc2
            end
        end, Acc, lists:seq(0, length(WordSets) - 1))
    end, Max, lists:seq(0, length(WordSets) - 1)).

lists:nth(Index, List) when is_integer(Index), is_list(List) ->
    lists:nth(Index + 1, List).