-module(solve).
-export([beauty_sum/1]).

beauty_sum(Nums) ->
    N = length(Nums),
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    LeftMin = lists:foldl(fun(I, Acc) -> 
        case I of
            0 -> [lists:nth(1, Nums)];
            _ -> [lists:nth(I+1, Nums) | Acc]
        end
    end, [], Left),
    RightMax = lists:foldr(fun(I, Acc) -> 
        case I of
            N-1 -> [lists:nth(N, Nums)];
            _ -> [lists:nth(I+1, Nums) | Acc]
        end
    end, [], Right),
    lists:sum([case (lists:nth(I+1, Nums) > lists:nth(I, LeftMin)) andalso (lists:nth(I+1, Nums) < lists:nth(I, RightMax)) of
        true -> 1;
        false -> 0
    end || I <- lists:seq(0, N-1)]).

-module(solve).
-export([beauty_sum/1]).

beauty_sum(Nums) ->
    N = length(Nums),
    LeftMin = lists:foldl(fun(I, Acc) ->
        case I of
            0 -> [lists:nth(1, Nums)];
            _ -> [min(lists:nth(I+1, Nums), lists:last(Acc)) | Acc]
        end
    end, [], lists:seq(0, N-1)),
    RightMax = lists:foldr(fun(I, Acc) ->
        case I of
            N-1 -> [lists:nth(N, Nums)];
            _ -> [max(lists:nth(I+1, Nums), lists:last(Acc)) | Acc]
        end
    end, [], lists:seq(0, N-1)),
    lists:sum([case (lists:nth(I+1, Nums) > lists:nth(I, LeftMin)) andalso (lists:nth(I+1, Nums) < lists:nth(I, RightMax)) of
        true -> 1;
        false -> 0
    end || I <- lists:seq(0, N-1)]).