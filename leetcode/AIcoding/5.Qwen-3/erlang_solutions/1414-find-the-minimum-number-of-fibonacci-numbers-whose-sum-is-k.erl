-module(fibonacci_numbers).
-export([find_min_fibonacci_numbers/1]).

find_min_fibonacci_numbers(K) ->
    Fibs = generate_fibs(K),
    find_min(Fibs, K, 0).

generate_fibs(Max) ->
    generate_fibs(1, 1, [], Max).

generate_fibs(A, B, Acc, Max) ->
    case A of
        _ when A > Max -> lists:reverse(Acc);
        _ -> generate_fibs(B, A + B, [A | Acc], Max)
    end.

find_min([], _, Count) ->
    Count;
find_min([F | Fs], Remaining, Count) ->
    if
        F > Remaining ->
            find_min(Fs, Remaining, Count);
        true ->
            find_min(Fs, Remaining - F, Count + 1)
    end.