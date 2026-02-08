-module(solution).
-export([find_num_complement/1]).

find_num_complement(N) ->
    BitCount = bsr(N, 1) + 1,
    MaxNum = (1 bsl BitCount) - 1,
    MaxNum - N.