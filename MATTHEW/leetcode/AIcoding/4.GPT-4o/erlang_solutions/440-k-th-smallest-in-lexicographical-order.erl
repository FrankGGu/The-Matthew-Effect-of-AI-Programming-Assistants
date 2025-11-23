-module(solution).
-export([find_kth_number/2]).

-spec find_kth_number(integer(), integer()) -> integer().
find_kth_number(n, k) ->
    find_kth_number(n, k, 1).

find_kth_number(_N, 1, prefix) ->
    prefix;
find_kth_number(n, k, prefix) ->
    step = calc_step(n, prefix, prefix + 1),
    if
        step < k ->
            find_kth_number(n, k - step, prefix + 1);
        true ->
            find_kth_number(n, k - 1, prefix * 10)
    end.

-spec calc_step(integer(), integer(), integer()) -> integer().
calc_step(n, n1, n2) when n1 > n; n2 > n ->
    max(0, n - n1 + 1);
calc_step(n, n1, n2) ->
    step = min(n + 1, n2) - n1,
    step + calc_step(n, n1 * 10, n2 * 10).

-spec max(integer(), integer()) -> integer().
max(A, B) when A >= B -> A;
max(_, B) -> B.

-spec min(integer(), integer()) -> integer().
min(A, B) when A =< B -> A;
min(_, B) -> B.
