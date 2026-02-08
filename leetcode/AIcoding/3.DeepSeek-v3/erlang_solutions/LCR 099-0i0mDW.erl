-spec min_path_sum(Grid :: [[integer()]]) -> integer().
min_path_sum(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    DP1 = set_element(1, 1, get_element(1, 1, Grid), DP, Grid),
    DP2 = fill_first_row(2, N, DP1, Grid),
    DP3 = fill_first_col(2, M, DP2, Grid),
    DP4 = fill_rest(2, 2, M, N, DP3, Grid),
    get_element(M, N, DP4).

get_element(I, J, Grid) ->
    lists:nth(J, lists:nth(I, Grid)).

set_element(I, J, Val, DP, Grid) ->
    Row = lists:nth(I, DP),
    NewRow = setnth(J, Val, Row),
    setnth(I, NewRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N-1, Val, T)].

fill_first_row(J, N, DP, Grid) when J =< N ->
    Val = get_element(1, J-1, DP) + get_element(1, J, Grid),
    NewDP = set_element(1, J, Val, DP, Grid),
    fill_first_row(J+1, N, NewDP, Grid);
fill_first_row(_, _, DP, _) -> DP.

fill_first_col(I, M, DP, Grid) when I =< M ->
    Val = get_element(I-1, 1, DP) + get_element(I, 1, Grid),
    NewDP = set_element(I, 1, Val, DP, Grid),
    fill_first_col(I+1, M, NewDP, Grid);
fill_first_col(_, _, DP, _) -> DP.

fill_rest(I, J, M, N, DP, Grid) when I =< M ->
    case J =< N of
        true ->
            Min = min(get_element(I-1, J, DP), get_element(I, J-1, DP)),
            Val = Min + get_element(I, J, Grid),
            NewDP = set_element(I, J, Val, DP, Grid),
            fill_rest(I, J+1, M, N, NewDP, Grid);
        false ->
            fill_rest(I+1, 2, M, N, DP, Grid)
    end;
fill_rest(_, _, _, _, DP, _) -> DP.