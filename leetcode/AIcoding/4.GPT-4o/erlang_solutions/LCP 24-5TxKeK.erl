-module(solution).
-export([num_game/1]).

num_game(N) when N rem 2 == 0 -> N div 2;
num_game(N) -> (N div 2) + 1.