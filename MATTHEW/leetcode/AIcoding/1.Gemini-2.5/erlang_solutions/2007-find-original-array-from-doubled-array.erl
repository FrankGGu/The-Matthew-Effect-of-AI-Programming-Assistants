-module(solution).
-export([find_original_array/1]).

build_freq_map(List) ->
    lists:foldl(fun(X, Map) ->
        gb_trees:update(X, fun(Count) -> Count + 1 end, 1, Map)
    end, gb_trees:empty(), List).

find_original_array(Changed) ->
    case length(Changed) rem 2 of
        1 ->
            [];
        _ ->
            FreqMap = build_freq_map(Changed),
            SortedChanged = lists:sort(Changed),
            reconstruct(SortedChanged, FreqMap, [])
    end.

reconstruct([], _FreqMap, Original) ->
    lists:reverse(Original);
reconstruct([X | Rest], FreqMap, Original) ->
    CountX = gb_trees:get(X, FreqMap),
    case CountX of
        0 ->
            reconstruct(Rest, FreqMap, Original);
        _ ->
            Target = X * 2,
            case X of
                0 ->
                    case CountX rem 2 of
                        1 ->
                            [];
                        _ ->
                            NewOriginal = lists:duplicate(CountX div 2, 0) ++ Original,
                            NewFreqMap = gb_trees:update(X, fun(_) -> 0 end, FreqMap),
                            reconstruct(Rest, NewFreqMap, NewOriginal)
                    end;
                _ ->
                    case gb_trees:lookup(Target, FreqMap) of
                        {value, CountTarget} when CountTarget >= CountX ->
                            NewOriginal = lists:duplicate(CountX, X) ++ Original,
                            NewFreqMap1 = gb_trees:update(X, fun(C) -> C - CountX end, FreqMap),
                            NewFreqMap2 = gb_trees:update(Target, fun(C) -> C - CountX end, NewFreqMap1),
                            reconstruct(Rest, NewFreqMap2, NewOriginal);
                        _ ->
                            []
                    end
            end
    end.