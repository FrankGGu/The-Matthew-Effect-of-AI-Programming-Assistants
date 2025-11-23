-module(solution).
-export([nums_same_consec_diff/2]).

nums_same_consec_diff(N, K) ->
    lists:flatmap(fun(X) -> bfs(X, N, K, 1) end, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

bfs(X, N, K, L) when L =< N ->
    case L of
        N -> [X];
        _ -> 
            LastDigit = X rem 10,
            lists:concat(
                case LastDigit + K of
                    D when D < 10 -> bfs(X * 10 + D, N, K, L + 1);
                    _ -> []
                end ++
                case LastDigit - K of
                    D when D >= 0 -> bfs(X * 10 + D, N, K, L + 1);
                    _ -> []
                end
            )
    end;
bfs(_, _, _, _) -> [].