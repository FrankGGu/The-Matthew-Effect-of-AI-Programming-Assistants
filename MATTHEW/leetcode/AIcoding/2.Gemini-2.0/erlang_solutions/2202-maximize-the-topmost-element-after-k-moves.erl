-module(maximize_topmost).
-export([maximumTop/2]).

maximumTop(Nums, K) ->
    Len = length(Nums),
    case Len of
        1 ->
            if K rem 2 == 0 then
                hd(Nums)
            else
                -1
            end;
        _ ->
            if K > Len then
                lists:max(Nums)
            else if K == Len then
                lists:max(lists:sublist(Nums, 1, K-1))
            else
                MaxRemoved = lists:max(lists:sublist(Nums, 1, K-1)),
                lists:max([MaxRemoved, lists:nth(K+1, Nums)])
            end
    end.