-module(solution).
-export([maximum_score/2]).

maximum_score(Nums, K) ->
    N = length(Nums),
    Left = lists:duplicate(N, -1),
    Right = lists:duplicate(N, N),
    St = [],
    {Left1, _} = build_left(Nums, Left, St, 0),
    {Right1, _} = build_right(Nums, Right, St, N - 1),
    Scores = lists:zipwith(fun(L, R) -> (R - L - 1) end, Left1, Right1),
    Pairs = lists:zip(Nums, Scores),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A >= B end, Pairs)),
    Result = calculate_score(Sorted, K, 1, 1),
    Result.

build_left([], Left, _, _) -> {Left, []};
build_left([H | T], Left, St, I) ->
    NewSt = pop_stack(H, St),
    NewLeft = case NewSt of
        [] -> setelement(I + 1, Left, -1);
        [{V, _} | _] -> setelement(I + 1, Left, V)
    end,
    NewSt1 = push_stack(H, I, NewSt),
    build_left(T, NewLeft, NewSt1, I + 1).

build_right(Nums, Right, St, I) when I < 0 -> {Right, St};
build_right(Nums, Right, St, I) ->
    H = lists:nth(I + 1, Nums),
    NewSt = pop_stack(H, St),
    NewRight = case NewSt of
        [] -> setelement(I + 1, Right, length(Nums));
        [{V, _} | _] -> setelement(I + 1, Right, V)
    end,
    NewSt1 = push_stack(H, I, NewSt),
    build_right(Nums, NewRight, NewSt1, I - 1).

pop_stack(_, []) -> [];
pop_stack(H, [{V, Pos} | T]) when V >= H -> pop_stack(H, T);
pop_stack(_, St) -> St.

push_stack(H, Pos, St) -> [{H, Pos} | St].

calculate_score([], _, _, Acc) -> Acc;
calculate_score(_, 0, _, Acc) -> Acc;
calculate_score([{Val, Cnt} | T], K, M, Acc) ->
    Take = min(K, Cnt),
    NewAcc = (Acc * pow(Val, Take, 1000000007)) rem 1000000007,
    calculate_score(T, K - Take, M + 1, NewAcc).

pow(_, 0, _) -> 1;
pow(X, 1, M) -> X rem M;
pow(X, Y, M) ->
    Temp = pow(X, Y div 2, M),
    TempSq = (Temp * Temp) rem M,
    case Y rem 2 of
        0 -> TempSq;
        1 -> (TempSq * X) rem M
    end.