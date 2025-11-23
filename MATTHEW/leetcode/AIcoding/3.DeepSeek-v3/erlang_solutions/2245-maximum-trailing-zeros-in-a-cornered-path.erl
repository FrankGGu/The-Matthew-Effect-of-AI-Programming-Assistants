-module(solution).
-export([max_trailing_zeros/1]).

max_trailing_zeros(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Prefix2 = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    Prefix5 = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    {P2, P5} = build_prefix(Grid, M, N, Prefix2, Prefix5),
    Max = 0,
    Max1 = find_max(M, N, P2, P5, Max),
    Max1.

build_prefix(Grid, M, N, Prefix2, Prefix5) ->
    {P2, P5} = lists:foldl(fun(I, {Acc2, Acc5}) ->
        Row = lists:nth(I, Grid),
        {RowP2, RowP5} = lists:foldl(fun(J, {AccRow2, AccRow5}) ->
            Num = lists:nth(J, Row),
            C2 = count_factor(Num, 2),
            C5 = count_factor(Num, 5),
            NewP2 = set_val(Acc2, I, J, get_val(Acc2, I-1, J) + get_val(Acc2, I, J-1) - get_val(Acc2, I-1, J-1) + C2),
            NewP5 = set_val(Acc5, I, J, get_val(Acc5, I-1, J) + get_val(Acc5, I, J-1) - get_val(Acc5, I-1, J-1) + C5),
            {NewP2, NewP5}
        end, {Acc2, Acc5}, lists:seq(1, N)),
        {RowP2, RowP5}
    end, {Prefix2, Prefix5}, lists:seq(1, M)),
    {P2, P5}.

count_factor(Num, Factor) ->
    count_factor(Num, Factor, 0).
count_factor(Num, Factor, Count) when Num rem Factor == 0 ->
    count_factor(Num div Factor, Factor, Count + 1);
count_factor(_, _, Count) ->
    Count.

get_val(Matrix, I, J) ->
    Row = lists:nth(I, Matrix),
    lists:nth(J, Row).

set_val(Matrix, I, J, Val) ->
    Row = lists:nth(I, Matrix),
    NewRow = set_nth(J, Val, Row),
    set_nth(I, NewRow, Matrix).

set_nth(1, Val, [_|T]) -> [Val|T];
set_nth(N, Val, [H|T]) -> [H|set_nth(N-1, Val, T)].

find_max(M, N, P2, P5, Max) ->
    lists:foldl(fun(I, AccMax) ->
        lists:foldl(fun(J, InnerMax) ->
            Total2 = get_val(P2, I, J) + get_val(P2, M, J) - get_val(P2, I-1, J),
            Total5 = get_val(P5, I, J) + get_val(P5, M, J) - get_val(P5, I-1, J),
            Cur = min(Total2, Total5),
            if Cur > InnerMax -> Cur; true -> InnerMax end
        end, AccMax, lists:seq(1, N))
    end, Max, lists:seq(1, M)).