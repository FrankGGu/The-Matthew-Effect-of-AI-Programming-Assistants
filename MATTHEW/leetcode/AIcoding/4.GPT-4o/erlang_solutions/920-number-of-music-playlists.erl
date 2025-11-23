-module(solution).
-export([count_playlists/3]).

count_playlists(N, L, K) ->
    M = 1000000007,
    Lists = lists:duplicate(L + 1, lists:duplicate(N + 1, 0)),
    Lists2 = lists:duplicate(N + 1, 0),
    Lists2[0] = 1,
    lists:foldl(fun(_, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            case J of
                0 -> Acc2;
                _ -> (Acc2 + (Acc[J - 1] * (N - J + 1)) rem M + (Acc2 + Acc[J] * max(0, J - K)) rem M) rem M
            end
        end, Lists2, lists:seq(0, N)) 
    end, Lists, lists:seq(1, L)),
    Lists[L][N].