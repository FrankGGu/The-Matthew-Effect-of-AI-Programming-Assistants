-spec find_kth_bit(N :: integer(), K :: integer()) -> char().
find_kth_bit(N, K) ->
    S = build_string(N),
    lists:nth(K, S).

build_string(1) ->
    "0";
build_string(N) ->
    Prev = build_string(N - 1),
    Prev ++ "1" ++ invert_reverse(Prev).

invert_reverse(S) ->
    lists:reverse([case C of $0 -> $1; $1 -> $0 end || C <- S]).