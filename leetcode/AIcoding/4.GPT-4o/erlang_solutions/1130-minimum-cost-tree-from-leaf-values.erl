-module(solution).
-export([mct_from_leaf_values/1]).

mct_from_leaf_values(Values) ->
    mct_from_leaf_values(Values, []).

mct_from_leaf_values([], Acc) ->
    lists:sum(Acc);
mct_from_leaf_values([H | T], Stack) ->
    mct_from_leaf_values(T, push(Stack, H)).

push([], H) -> [H];
push([Top | Rest], H) when Top < H -> push(Rest, Top + H);
push(Stack, H) -> [H | Stack].