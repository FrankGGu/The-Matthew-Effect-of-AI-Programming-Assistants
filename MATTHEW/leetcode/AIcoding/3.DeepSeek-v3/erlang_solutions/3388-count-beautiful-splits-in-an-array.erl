-module(solution).
-export([beautiful_splits/1]).

beautiful_splits(Nums) ->
    Prefix = lists:foldl(fun(X, Acc) -> [maps:put(X, true, hd(Acc)) | Acc] end, [maps:new()], Nums),
    Suffix = lists:foldr(fun(X, Acc) -> [maps:put(X, true, hd(Acc)) | Acc] end, [maps:new()], Nums),
    lists:foldl(fun(I, Sum) ->
        PrefixMap = lists:nth(I, Prefix),
        SuffixMap = lists:nth(I + 1, Suffix),
        case maps:size(PrefixMap) =:= maps:size(SuffixMap) of
            true -> Sum + 1;
            false -> Sum
        end
    end, 0, lists:seq(1, length(Nums) - 1)).