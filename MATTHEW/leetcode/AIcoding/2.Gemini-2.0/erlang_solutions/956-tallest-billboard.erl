-module(tallest_billboard).
-export([tallestBillboard/1]).

tallestBillboard(Rods) ->
    Map = gb_trees:empty(),
    Map1 = processRods(Rods, 0, Map),
    case gb_trees:lookup(0, Map1) of
        {_, H} -> H;
        _ -> 0
    end.

processRods([], Sum, Map) ->
    Map;
processRods([Rod | Rest], Sum, Map) ->
    Map1 = gb_trees:enter(Sum + Rod, max(getVal(Sum + Rod, Map), getVal(Sum, Map) + Rod), Map),
    Map2 = gb_trees:enter(Sum - Rod, max(getVal(Sum - Rod, Map), getVal(Sum, Map)), Map1),
    processRods(Rest, Sum, Map2).

getVal(Key, Map) ->
    case gb_trees:lookup(Key, Map) of
        {_, Val} -> Val;
        _ -> 0
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.