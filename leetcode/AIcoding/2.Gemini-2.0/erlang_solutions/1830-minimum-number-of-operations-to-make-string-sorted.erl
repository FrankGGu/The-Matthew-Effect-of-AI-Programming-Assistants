-module(minimum_operations).
-export([make_string_sorted/1]).

make_string_sorted(S) ->
    N = length(S),
    Mod = 1000000007,
    Counts = lists:foldl(fun(C, Acc) ->
                                 case maps:is_key(C, Acc) of
                                     true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
                                     false -> maps:put(C, 1, Acc)
                                 end
                             end, #{}, S),
    Factorial = factorial_memo(N, Mod),
    InvFactorial = inv_factorial_memo(N, Mod),

    List = string:to_list(S),

    calculate_operations(List, Counts, Factorial, InvFactorial, Mod, 0).

calculate_operations([], _Counts, _Factorial, _InvFactorial, _Mod, Acc) ->
    Acc;
calculate_operations([H|T], Counts, Factorial, InvFactorial, Mod, Acc) ->
    Smaller = lists:foldl(fun(C, Count) ->
                                  case C < H of
                                      true -> Count + maps:get(C, Counts, 0);
                                      false -> Count
                                  end
                              end, 0, maps:keys(Counts)),

    N = length([H|T]) - 1,

    Permutations = (Factorial rem Mod * (inv_modulo(factorial_counts_product(Counts, InvFactorial, Mod),Mod) rem Mod)) rem Mod,

    NewAcc = (Acc + (Smaller rem Mod * Permutations rem Mod) rem Mod) rem Mod,

    NewCounts = case maps:get(H, Counts) of
                    1 -> maps:remove(H, Counts);
                    _ -> maps:update(H, maps:get(H, Counts) - 1, Counts)
                end,

    calculate_operations(T, NewCounts, Factorial, InvFactorial, Mod, NewAcc).

factorial_counts_product(Counts, InvFactorial, Mod) ->
    lists:foldl(fun({_, V}, Acc) ->
                        (Acc * InvFactorial[V]) rem Mod
                end, 1, maps:to_list(Counts)).

factorial_memo(N, Mod) ->
    factorial_memo(N, 1, [1], Mod).

factorial_memo(0, _, Acc, _) ->
    lists:reverse(Acc);
factorial_memo(N, Current, Acc, Mod) ->
    factorial_memo(N - 1, (Current * N) rem Mod, [ (Current * N) rem Mod | Acc], Mod).

inv_factorial_memo(N, Mod) ->
    Factorials = factorial_memo(N, Mod),
    Last = lists:last(Factorials),
    LastInv = inv_modulo(Last, Mod),
    inv_factorial_memo(Factorials, LastInv, [], Mod).

inv_factorial_memo([], _, Acc, _) ->
    lists:reverse(Acc);
inv_factorial_memo([H | T], Current, Acc, Mod) ->
    Next = (Current * H) rem Mod,
    inv_factorial_memo(T, Next, [Current | Acc], Mod).

inv_modulo(A, Mod) ->
    power(A, Mod - 2, Mod).

power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) ->
    Acc;
power(Base, Exp, Mod, Acc) when Exp rem 2 == 0 ->
    power((Base * Base) rem Mod, Exp div 2, Mod, Acc);
power(Base, Exp, Mod, Acc) ->
    power(Base, Exp - 1, Mod, (Acc * Base) rem Mod).