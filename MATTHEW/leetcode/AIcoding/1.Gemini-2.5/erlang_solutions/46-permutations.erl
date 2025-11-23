-module(solution).
-export([permute/1]).

permute(Nums) ->
    perm(Nums).

perm([]) ->
    [[]];
perm([H|T]) ->
    PermsOfT = perm(T),
    insert_everywhere(H, PermsOfT).

insert_everywhere(_X, []) ->
    [];
insert_everywhere(X, [P|Ps]) ->
    insert_all_positions(X, P) ++ insert_everywhere(X, Ps).

insert_all_positions(X, []) ->
    [[X]];
insert_all_positions(X, [H|T]) ->
    [[X,H|T] | lists:map(fun(Rest) -> [H|Rest] end, insert_all_positions(X, T))].