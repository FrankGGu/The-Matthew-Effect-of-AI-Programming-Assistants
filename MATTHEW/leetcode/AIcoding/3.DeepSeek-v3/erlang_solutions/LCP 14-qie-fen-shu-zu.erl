-module(solution).
-export([split_array/1]).

split_array(Nums) ->
    N = length(Nums),
    case N of
        0 -> 0;
        1 -> 0;
        _ ->
            LeftMax = lists:foldl(fun(X, Acc) -> max(X, Acc) end, hd(Nums), tl(Nums)),
            RightMin = lists:foldr(fun(X, Acc) -> min(X, Acc) end, lists:last(Nums), lists:droplast(Nums)),
            case LeftMax =< RightMin of
                true -> 1;
                false -> 0
            end
    end.