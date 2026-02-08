-module(solution).
-export([numMusicPlaylists/3]).

numMusicPlaylists(N, L, K) ->
    M = 1000000007,
    DP = lists:duplicate(L + 1, lists:duplicate(N + 1, 0)),
    DP = lists:foldl(fun(_, DP) -> 
        lists:foldl(fun(0, _) -> 1 end, DP, lists:seq(1, N)) 
    end, lists:foldl(fun(_, _) -> 0 end, DP, lists:seq(1, L)), lists:seq(0, L)),
    lists:foldl(fun(I, DP) -> 
        lists:foldl(fun(J, DP) -> 
            case J of 
                1 -> 
                    lists:foldl(fun(X, DP) -> 
                        lists:update_element(J, (DP#dp{X = (DP#dp{X} + 1) rem M}), DP) 
                    end, DP, lists:seq(1, N)) 
                _ -> 
                    lists:update_element(J, (DP#dp{X = (DP#dp{X} + (DP#dp{I - 1, J - 1} * (N - J + 1)) rem M)}), DP)
            end 
        end, DP, lists:seq(1, N))
    end, DP, lists:seq(1, L)),
    lists:nth(1, lists:nth(L, DP)).