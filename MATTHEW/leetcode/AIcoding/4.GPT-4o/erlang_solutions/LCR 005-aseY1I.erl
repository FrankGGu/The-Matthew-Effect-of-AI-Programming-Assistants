-module(solution).
-export([max_product/1]).

max_product(Words) ->
    WordLens = lists:map(fun (W) -> {binary_to_list(W), length(binary_to_list(W))} end, Words),
    MaxProduct = lists:foldl(fun ({Word1, Len1}, Acc) ->
        lists:foldl(fun ({Word2, Len2}, AccInner) ->
            if
                not lists:any(fun (C) -> lists:member(C, Word1) end, Word2) -> 
                    max(AccInner, Len1 * Len2);
                true -> 
                    AccInner
            end
        end, Acc, tl(WordLens))
    end, 0, WordLens),
    MaxProduct.