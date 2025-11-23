-module(solution).
-export([cycle_length_queries/1]).

cycle_length_queries(Queries) ->
    lists:map(fun([U, V]) -> solve_query(U, V) end, Queries).

solve_query(U, V) ->
    L = lca(U, V),
    DU = node_depth(U),
    DV = node_depth(V),
    DL = node_depth(L),
    DU + DV - 2 * DL + 1.

lca(U, V) ->
    DU = node_depth(U),
    DV = node_depth(V),
    {U1, V1} = equalize_depth(U, DU, V, DV),
    find_common_ancestor(U1, V1).

equalize_depth(U, DU, V, DV) when DU == DV -> {U, V};
equalize_depth(U, DU, V, DV) when DU > DV -> equalize_depth(U div 2, DU - 1, V, DV);
equalize_depth(U, DU, V, DV) when DV > DU -> equalize_depth(U, DU, V div 2, DV - 1).

find_common_ancestor(U, V) when U == V -> U;
find_common_ancestor(U, V) -> find_common_ancestor(U div 2, V div 2).

node_depth(N) ->
    trunc(math:log2(N)).