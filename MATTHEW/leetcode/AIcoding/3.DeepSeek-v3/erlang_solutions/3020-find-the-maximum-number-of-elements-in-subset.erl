-module(solution).
-export([maximum_length/1]).

maximum_length(Nums) ->
    Sorted = lists:sort(Nums),
    Map = maps:new(),
    {Max, _} = lists:foldl(fun(Num, {MaxAcc, AccMap}) ->
        case maps:get(Num div 2, AccMap, undefined) of
            undefined ->
                case Num rem 2 of
                    0 -> 
                        case maps:get(Num div 2, AccMap, undefined) of
                            undefined -> 
                                NewMap = maps:put(Num, 1, AccMap),
                                {max(MaxAcc, 1), NewMap};
                            _ -> 
                                {MaxAcc, AccMap}
                        end;
                    _ -> 
                        NewMap = maps:put(Num, 1, AccMap),
                        {max(MaxAcc, 1), NewMap}
                end;
            Len ->
                NewLen = Len + 1,
                NewMap = maps:put(Num, NewLen, AccMap),
                {max(MaxAcc, NewLen), NewMap}
        end
    end, {0, Map}, Sorted),
    Max.