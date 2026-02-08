-module(solution).
-export([find_max_form/3]).

find_max_form(Strs, M, N) ->
    Counts = lists:map(fun count_zeros_ones/1, Strs),
    InitialDP = array:new(M + 1, fun(_) -> array:new(N + 1, 0) end),

    FinalDP = lists:foldl(fun({ZerosS, OnesS}, CurrentDP) ->
        lists:foldl(fun(I, AccDP_I) ->
            lists:foldl(fun(J, AccDP_J) ->
                if I >= ZerosS andalso J >= OnesS ->
                    CurrentRow = array:get(I, AccDP_J),
                    ValCurrent = array:get(J, CurrentRow),

                    PrevRow = array:get(I - ZerosS, AccDP_J),
                    ValPrev = array:get(J - OnesS, PrevRow),

                    NewVal = max(ValCurrent, 1 + ValPrev),

                    UpdatedRow = array:set(J, NewVal, CurrentRow),
                    array:set(I, UpdatedRow, AccDP_J);
                true ->
                    AccDP_J
                end
            end, AccDP_I, lists:seq(N, OnesS, -1))
        end, CurrentDP, lists:seq(M, ZerosS, -1))
    end, InitialDP, Counts),

    RowM = array:get(M, FinalDP),
    array:get(N, RowM).

count_zeros_ones(Str) ->
    lists:foldl(fun(C, {Zeros, Ones}) ->
        if C == $0 -> {Zeros + 1, Ones};
           true -> {Zeros, Ones + 1}
        end
    end, {0, 0}, Str).