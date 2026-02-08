-module(solution).
-export([numTeams/1]).

numTeams(RatingList) ->
    RatingTuple = list_to_tuple(RatingList),
    N = tuple_size(RatingTuple),
    count_teams_i(RatingTuple, N, 0, 0).

count_teams_i(RatingTuple, N, I, Acc) when I < N - 2 ->
    RI = element(I + 1, RatingTuple),
    Acc1 = count_teams_j(RatingTuple, N, I, RI, I + 1, Acc),
    count_teams_i(RatingTuple, N, I + 1, Acc1);
count_teams_i(_RatingTuple, _N, _I, Acc) ->
    Acc.

count_teams_j(RatingTuple, N, I, RI, J, Acc) when J < N - 1 ->
    RJ = element(J + 1, RatingTuple),
    Acc1 = count_teams_k(RatingTuple, N, I, RI, J, RJ, J + 1, Acc),
    count_teams_j(RatingTuple, N, I, RI, J + 1, Acc1);
count_teams_j(_RatingTuple, _N, _I, _RI, _J, Acc) ->
    Acc.

count_teams_k(RatingTuple, N, I, RI, J, RJ, K, Acc) when K < N ->
    RK = element(K + 1, RatingTuple),
    NewAcc = if
        (RI < RJ andalso RJ < RK) orelse (RI > RJ andalso RJ > RK) ->
            Acc + 1;
        true ->
            Acc
    end,
    count_teams_k(RatingTuple, N, I, RI, J, RJ, K + 1, NewAcc);
count_teams_k(_RatingTuple, _N, _I, _RI, _J, _RJ, _K, Acc) ->
    Acc.