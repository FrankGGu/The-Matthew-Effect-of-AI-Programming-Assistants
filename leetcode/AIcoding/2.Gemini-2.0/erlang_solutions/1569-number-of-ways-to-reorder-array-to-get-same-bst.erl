-module(number_of_ways_to_reorder_array_to_get_same_bst).
-export([num_ways/1]).

num_ways(Nums) ->
  (ways(Nums) - 1) rem 1000000007.

ways([]) -> 1;
ways([H|T]) ->
  {Smaller, Larger} = lists:partition(fun(X) -> X < H end, T),
  (comb(length(Smaller) + length(Larger), length(Smaller)) * ways(Smaller) * ways(Larger)) rem 1000000007.

comb(N, K) ->
  case K =:= 0 orelse K =:= N ->
    1;
  true ->
    Fact = factorial_memoized(N),
    FactK = factorial_memoized(K),
    FactNK = factorial_memoized(N - K),
    safe_div((Fact rem 1000000007) , ((FactK * FactNK) rem 1000000007)) rem 1000000007
  end.

factorial_memoized(N) ->
    factorial_memoized(N, [{0, 1}, {1, 1}]).

factorial_memoized(N, Memo) ->
    case lists:keyfind(N, 1, Memo) of
        {N, Fact} ->
            Fact;
        false ->
            Prev = factorial_memoized(N - 1, Memo),
            Fact = (N * Prev) rem 1000000007,
            factorial_memoized(N, [{N, Fact} | Memo])
    end.

safe_div(A, B) ->
    safe_div(A, B, 1000000007).

safe_div(A, B, M) ->
    A * power(B, M - 2, M) rem M.

power(Base, Exp, M) ->
    power(Base, Exp, M, 1).

power(_, 0, _, Acc) ->
    Acc;
power(Base, Exp, M, Acc) when Exp rem 2 == 0 ->
    power(Base * Base rem M, Exp div 2, M, Acc) rem M;
power(Base, Exp, M, Acc) ->
    power(Base, Exp - 1, M, Base * Acc rem M) rem M.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).