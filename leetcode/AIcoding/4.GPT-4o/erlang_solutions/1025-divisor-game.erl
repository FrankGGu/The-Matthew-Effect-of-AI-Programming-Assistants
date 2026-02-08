-module(solution).
-export([divisorGame/1]).

divisorGame(N) when N rem 2 == 0 -> true;
divisorGame(_) -> false.