-module(solution).
-export([query_string/2]).

query_string(S, N) ->
    Len = length(S),
    MaxLen = trunc(math:log2(N)) + 1,
    Valid = lists:seq(1, N),
    ValidBits = lists:map(fun(X) -> bin_to_string(X, MaxLen) end, Valid),
    lists:all(fun(Bit) -> contains_substring(S, Bit) end, ValidBits).

contains_substring(S, Sub) ->
    SLen = length(S),
    SubLen = length(Sub),
    lists:any(fun(I) -> lists:sublist(S, I, SubLen) =:= Sub end, lists:seq(0, SLen - SubLen)).

bin_to_string(X, Len) ->
    Bin = integer_to_list(X, 2),
    Pad = lists:duplicate(Len - length(Bin), $0),
    Pad ++ Bin.