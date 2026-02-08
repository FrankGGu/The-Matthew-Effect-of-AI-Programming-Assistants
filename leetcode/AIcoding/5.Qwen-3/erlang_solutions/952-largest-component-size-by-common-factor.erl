-module(largest_component_size_by_common_factor).
-export([largestComponentSize/1]).

largestComponentSize(Nums) ->
    N = length(Nums),
    Parent = lists:seq(0, N-1),
    FactorMap = buildFactorMap(Nums),
    UnionFind = unionFind(Parent, FactorMap, Nums),
    Count = maps:from_list([{I, 1} || I <- lists:seq(0, N-1)]),
    lists:foldl(fun(I, Acc) ->
        Root = findRoot(UnionFind, I),
        Count2 = maps:update(Root, maps:get(Root, Count) + 1, Count),
        Acc#{{root := Root}} = Acc,
        Acc
    end, Count, lists:seq(0, N-1)),
    lists:max(maps:values(Count)).

buildFactorMap(Nums) ->
    buildFactorMap(Nums, #{}).

buildFactorMap([], Map) ->
    Map;
buildFactorMap([N | Rest], Map) ->
    Factors = getFactors(N),
    NewMap = lists:foldl(fun(F, M) -> maps:update(F, [N | maps:get(F, M, [])], M) end, Map, Factors),
    buildFactorMap(Rest, NewMap).

getFactors(N) ->
    getFactors(N, 2, []).

getFactors(N, I, Factors) when I * I > N ->
    case N > 1 of
        true -> [N | Factors];
        false -> Factors
    end;
getFactors(N, I, Factors) ->
    case N rem I == 0 of
        true ->
            getFactors(N div I, I, [I | Factors]);
        false ->
            getFactors(N, I + 1, Factors)
    end.

unionFind(Parent, FactorMap, Nums) ->
    lists:foreach(fun({F, Indices}) ->
        lists:foreach(fun(I) ->
            lists:foreach(fun(J) ->
                if I /= J -> union(Parent, I, J) end
            end, Indices)
        end, Indices)
    end, maps:to_list(FactorMap)),
    Parent.

union(Parent, X, Y) ->
    PX = findRoot(Parent, X),
    PY = findRoot(Parent, Y),
    if PX /= PY -> lists:setelement(PX + 1, Parent, PY) end.

findRoot(Parent, X) ->
    if lists:nth(X + 1, Parent) == X -> X;
       true -> findRoot(Parent, lists:nth(X + 1, Parent))
    end.