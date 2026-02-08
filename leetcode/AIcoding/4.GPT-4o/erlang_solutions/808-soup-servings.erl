-module(solution).
-export([soupServings/1]).

soupServings(N) when N > 5000 -> 1.0;
soupServings(N) -> 
    F = fun(N_A, N_B) when N_A =< 0, N_B =< 0 -> 0.5;
               (N_A, N_B) when N_A =< 0 -> 1.0;
               (N_A, N_B) when N_B =< 0 -> 0.0;
               (N_A, N_B) -> 
                   (F(N_A - 100, N_B) + 
                    F(N_A - 75, N_B - 25) + 
                    F(N_A - 50, N_B - 50) + 
                    F(N_A - 25, N_B - 75)) / 4.0
    end,
    F(N, N).