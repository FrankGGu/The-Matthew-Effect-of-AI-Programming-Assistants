-module(solution).
-export([find_fibonacci_numbers/1]).

find_fibonacci_numbers(K) when K < 1 -> 0;
find_fibonacci_numbers(K) ->
    Fibonacci = [1, 2],
    Fibonacci = generate_fibonacci(Fibonacci, K),
    find_min_fib_count(Fibonacci, K).

generate_fibonacci(Fib, K) when lists:last(Fib) < K ->
    NewFib = lists:append(Fib, [lists:last(Fib) + lists:nth(length(Fib) - 1, Fib)]),
    generate_fibonacci(NewFib, K);
generate_fibonacci(Fib, _) -> Fib.

find_min_fib_count([], _) -> 0;
find_min_fib_count(Fib, K) ->
    case lists:reverse(Fib) of
        [] -> 0;
        [H | T] ->
            if 
                H > K -> find_min_fib_count(T, K);
                true -> 1 + find_min_fib_count(T, K - H)
            end
    end.