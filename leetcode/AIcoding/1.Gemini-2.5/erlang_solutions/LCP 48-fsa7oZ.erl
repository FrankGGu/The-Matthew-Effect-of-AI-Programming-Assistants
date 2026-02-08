-module(solution).
-export([solve/2]).

solve(_N, Pieces) ->
    NimSum = lists:foldl(fun([R, C], Acc) ->
                                 % The Grundy value for a single piece at (R, C) is R + C - 2.
                                 % This is because a piece at (R, C) can move to any (R', C')
                                 % where 1 <= R' <= R and 1 <= C' <= C, and (R', C') != (R, C).
                                 % The set of Grundy values for these reachable positions (R', C')
                                 % is {R' + C' - 2 | 1 <= R' <= R, 1 <= C' <= C, (R', C') != (R, C)}.
                                 % This set contains all integers from 0 up to (R + C - 3).
                                 % For example, (1,1) -> 0, (1,2) -> 1, (2,1) -> 1, ..., (R, C-1) -> R+C-3, (R-1, C) -> R+C-3.
                                 % The mex (Minimum Excluded value) of this set is R + C - 2.
                                 G = R + C - 2,
                                 Acc bxor G
                         end, 0, Pieces),
    NimSum /= 0.