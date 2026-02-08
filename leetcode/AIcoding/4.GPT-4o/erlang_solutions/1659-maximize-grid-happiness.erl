-module(solution).
-export([maximizeGridHappiness/3]).

maximizeGridHappiness(N, M, K) ->
    MaxHappiness = fun(N, M, K, H, G, P) ->
        case N of
            0 -> H;
            _ -> 
                case G of
                    0 -> MaxHappiness(N - 1, M, K, H + P, G + 1, P);
                    _ when G < M -> 
                        MaxHappiness(N, M, K, H + P, G + 1, P);
                    _ -> 
                        MaxHappiness(N - 1, M, K, H + P, 0, P)
                end
        end
    end,
    MaxHappiness(N, M, K, 0, 0, K).