-spec min_fibonacci_numbers(K :: integer()) -> integer().
min_fibonacci_numbers(K) ->
    Fibs = generate_fibs(K),
    count_min_fibs(K, Fibs, 0).

generate_fibs(K) ->
    generate_fibs(K, [1, 1]).

generate_fibs(K, [H1, H2 | _] = Fibs) ->
    Next = H1 + H2,
    if
        Next > K -> lists:reverse(Fibs);
        true -> generate_fibs(K, [Next | Fibs])
    end.

count_min_fibs(0, _, Count) -> Count;
count_min_fibs(K, [H | T], Count) ->
    if
        H =< K -> count_min_fibs(K - H, T, Count + 1);
        true -> count_min_fibs(K, T, Count)
    end.