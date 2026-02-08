-spec max_side_length(Mat :: [[integer()]], Threshold :: integer()) -> integer().
max_side_length(Mat, Threshold) ->
    M = length(Mat),
    N = length(hd(Mat)),
    Prefix = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    Prefix1 = build_prefix(Mat, Prefix, 1, 1),
    MaxLen = min(M, N),
    find_max_len(Prefix1, MaxLen, Threshold, 0).

build_prefix([], Prefix, _, _) -> Prefix;
build_prefix([Row | Rest], Prefix, I, _) ->
    Prefix1 = build_row_prefix(Row, Prefix, I, 1),
    build_prefix(Rest, Prefix1, I + 1, 1).

build_row_prefix([], Prefix, _, _) -> Prefix;
build_row_prefix([Val | Rest], Prefix, I, J) ->
    Prefix1 = set_prefix_val(Prefix, I, J, Val + get_prefix_val(Prefix, I-1, J) + get_prefix_val(Prefix, I, J-1) - get_prefix_val(Prefix, I-1, J-1)),
    build_row_prefix(Rest, Prefix1, I, J + 1).

get_prefix_val(Prefix, I, J) ->
    lists:nth(J, lists:nth(I + 1, Prefix)).

set_prefix_val(Prefix, I, J, Val) ->
    Row = lists:nth(I + 1, Prefix),
    NewRow = setnth(J, Val, Row),
    setnth(I + 1, NewRow, Prefix).

setnth(1, Val, [_ | Rest]) -> [Val | Rest];
setnth(N, Val, [H | Rest]) -> [H | setnth(N - 1, Val, Rest)].

find_max_len(_, 0, _, Ans) -> Ans;
find_max_len(Prefix, Len, Threshold, Ans) ->
    case check_len(Prefix, Len, Threshold) of
        true -> Len;
        false -> find_max_len(Prefix, Len - 1, Threshold, Ans)
    end.

check_len(Prefix, Len, Threshold) ->
    M = length(Prefix) - 1,
    N = length(hd(Prefix)) - 1,
    check_squares(Prefix, Len, Threshold, M, N).

check_squares(_, _, _, M, N) when Len > M; Len > N -> false;
check_squares(Prefix, Len, Threshold, M, N) ->
    lists:any(fun(I) ->
        lists:any(fun(J) ->
            Sum = get_prefix_val(Prefix, I, J) - get_prefix_val(Prefix, I - Len, J) - get_prefix_val(Prefix, I, J - Len) + get_prefix_val(Prefix, I - Len, J - Len),
            Sum =< Threshold
        end, lists:seq(Len, N))
    end, lists:seq(Len, M)).