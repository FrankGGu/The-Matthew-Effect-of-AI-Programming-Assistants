-module(solution).
-export([construct/1]).

construct(Graph) ->
    construct(Graph, 0, 0, []).

construct([], _, _, Acc) ->
    lists:reverse(Acc);
construct([[] | Rest], _, Y, Acc) ->
    construct(Rest, 0, Y + 1, Acc);
construct([[Node | Next] | Rest], X, Y, Acc) ->
    NewAcc = [{Node, {X, Y}} | Acc],
    construct([Next | Rest], X + 1, Y, NewAcc).