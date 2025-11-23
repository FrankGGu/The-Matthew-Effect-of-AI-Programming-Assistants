-module(solve).
-export([rob/1]).

rob([]) -> 0;
rob([H|T]) -> max(H + rob(tl(T)), rob(T)).