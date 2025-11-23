-module(count_ways).
-export([solve/1]).

solve(Prev) ->
    N = length(Prev);
    Fac = lists:map(fun(I) -> factorial(I) end, lists:seq(0, N));
    Mod = 1000000007;

    graph_size(N, Prev, 0, Fac, Mod).

graph_size(N, Prev, Start, Fac, Mod) ->
    graph_size_helper(N, Prev, Start, lists:seq(0, N - 1), 1, Fac, Mod).

graph_size_helper(_, _, _, [], Acc, _, _) ->
    Acc;
graph_size_helper(N, Prev, Start, Nodes, Acc, Fac, Mod) ->
    Children = [Node || Node <- Nodes, lists:nth(Node + 1, Prev) == Start],
    NumChildren = length(Children),
    Remaining = Nodes -- Children,
    NewAcc = (Acc * comb(N - 1 - Start, NumChildren, Fac, Mod)) rem Mod,
    NewAcc2 = lists:foldl(fun(Child, Acc2) -> graph_size_helper(N, Prev, Child, Remaining, Acc2, Fac, Mod) end, NewAcc, Children),
    NewAcc2.

comb(N, K, Fac, Mod) ->
    if
        K < 0 or K > N ->
            0;
        true ->
            (Fac !! (N + 1) * mod_inverse(Fac !! (K + 1), Mod) rem Mod * mod_inverse(Fac !! (N - K + 1), Mod) rem Mod) rem Mod
    end.

factorial(N) ->
    factorial_helper(N, 1).

factorial_helper(0, Acc) ->
    Acc;
factorial_helper(N, Acc) ->
    factorial_helper(N - 1, (Acc * N) rem 1000000007).

mod_inverse(A, Mod) ->
    power(A, Mod - 2, Mod).

power(Base, Exp, Mod) ->
    power_helper(Base, Exp, 1, Mod).

power_helper(_, 0, Acc, _) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) ->
    if
        Exp rem 2 == 0 ->
            power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod);
        true ->
            power_helper(Base, Exp - 1, (Acc * Base) rem Mod, Mod)
    end.