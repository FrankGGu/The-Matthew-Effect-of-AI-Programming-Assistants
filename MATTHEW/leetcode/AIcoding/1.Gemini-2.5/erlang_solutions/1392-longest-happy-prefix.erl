-module(solution).
-export([longestPrefix/1]).

longestPrefix(S) ->
    N = length(S),
    if N == 0 ->
        [];
       true ->
        BinS = list_to_binary(S),

        LPS = array:new([{size, N}, {fixed, true}]),
        LPS0 = array:set(0, 0, LPS),

        FinalLPS = build_lps_loop(1, N, 0, BinS, LPS0),

        ResultLen = array:get(N - 1, FinalLPS),
        binary_to_list(binary:part(BinS, 0, ResultLen))
    end.

build_lps_loop(I, N, Len, BinS, LPS) when I < N ->
    CurrentChar = binary:at(BinS, I),

    ProperLen = find_proper_len(Len, CurrentChar, BinS, LPS),

    UpdatedLen = if CurrentChar == binary:at(BinS, ProperLen) -> ProperLen + 1;
                    true -> ProperLen
                 end,

    UpdatedLPS = array:set(I, UpdatedLen, LPS),
    build_lps_loop(I + 1, N, UpdatedLen, BinS, UpdatedLPS);
build_lps_loop(N, N, _Len, _BinS, LPS) ->
    LPS.

find_proper_len(Len, CurrentCharI, BinS, LPS) when Len > 0 ->
    CharLen = binary:at(BinS, Len),
    if CurrentCharI /= CharLen ->
        find_proper_len(array:get(Len - 1, LPS), CurrentCharI, BinS, LPS);
       true ->
        Len
    end;
find_proper_len(0, _CurrentCharI, _BinS, _LPS) ->
    0.