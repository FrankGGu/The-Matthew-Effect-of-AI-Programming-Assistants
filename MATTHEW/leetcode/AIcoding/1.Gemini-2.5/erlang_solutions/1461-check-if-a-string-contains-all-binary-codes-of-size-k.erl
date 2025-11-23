-module(solution).
-export([hasAllCodes/2]).

hasAllCodes(S, K) ->
    N = string:len(S),
    ExpectedCount = round(math:pow(2, K)),
    if
        N < K ->
            false;
        N - K + 1 < ExpectedCount ->
            false;
        true ->
            Codes = sets:new(),
            hasAllCodes_loop(1, N - K + 1, S, K, Codes, ExpectedCount)
    end.

hasAllCodes_loop(I, MaxI, S, K, Codes, ExpectedCount) ->
    if
        I > MaxI ->
            sets:size(Codes) == ExpectedCount;
        sets:size(Codes) == ExpectedCount ->
            true;
        true ->
            Sub = string:substr(S, I, K),
            NewCodes = sets:add_element(Sub, Codes),
            hasAllCodes_loop(I + 1, MaxI, S, K, NewCodes, ExpectedCount)
    end.