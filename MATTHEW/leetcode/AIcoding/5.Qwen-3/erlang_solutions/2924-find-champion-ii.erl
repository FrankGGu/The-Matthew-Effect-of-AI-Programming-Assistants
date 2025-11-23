-module(find_champion_ii).
-export([find_champion/1]).

find_champion(Results) ->
    Players = lists:seq(1, length(Results) + 1),
    Graph = build_graph(Results),
    find_champion(Graph, Players).

build_graph([]) ->
    #{}
;
build_graph([[A,B] | Rest]) ->
    Graph = build_graph(Rest),
    AMap = maps:get(A, Graph, #{}),
    BMap = maps:get(B, Graph, #{}),
    maps:put(A, maps:put(B, true, AMap), maps:put(B, BMap, Graph)).

find_champion(_, []) ->
    [];
find_champion(Graph, [Player | Rest]) ->
    case is_champion(Graph, Player) of
        true ->
            [Player];
        false ->
            find_champion(Graph, Rest)
    end.

is_champion(Graph, Player) ->
    lists:all(fun (Other) -> maps:is_key(Other, maps:get(Player, Graph, #{})) end, maps:keys(Graph)).