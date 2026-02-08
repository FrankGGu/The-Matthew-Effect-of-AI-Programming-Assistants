-module(string_compression_iii).
-export([get_length_of_optimal_compression/2]).

get_length_of_optimal_compression(S, K) ->
    Len = length(S),
    Memo = array:new([Len + 1, K + 1], {undefined}),
    get_length_of_optimal_compression_helper(S, 0, K, Memo).

get_length_of_optimal_compression_helper(S, Start, K, Memo) ->
    case array:get({Start, K}, Memo) of
        undefined ->
            Len = length(S),
            if Start >= Len then
                Result = 0
            else if K =:= 0 then
                Result = compress(lists:sublist(S, Start + 1, Len - Start))
            else
                Result1 = get_length_of_optimal_compression_helper(S, Start + 1, K - 1, Memo),
                Result2 = compress_prefix(S, Start, K),
                Result = min(Result1, Result2)
            end,
            array:set({Start, K}, Result, Memo),
            Result;
        Result ->
            Result
    end.

compress_prefix(S, Start, K) ->
    Len = length(S),
    Char = lists:nth(Start + 1, S),
    Count = 0,
    Diff = 0,
    Result = infinity,
    for(I = Start; I < Len; I++) do
        if lists:nth(I + 1, S) =:= Char then
            Count = Count + 1
        else
            Diff = Diff + 1
        end,
        if Diff > K then
            exit
        end,
        PrefixLength = get_length(Count),
        RemainingLength = get_length_of_optimal_compression_helper(S, I + 1, K - Diff, array:new([Len + 1, K + 1], {undefined})),
        Result = min(Result, PrefixLength + RemainingLength)
    end,
    Result.

compress(S) ->
    compress_helper(S, 0, 0, []).

compress_helper([], LastChar, Count, Acc) ->
    Length = case Count > 0 of
                 true -> get_length(Count) + 1;
                 false -> 0
             end,
    lists:sum([Length | Acc]);
compress_helper([H|T], LastChar, Count, Acc) ->
    if H =:= LastChar then
        compress_helper(T, LastChar, Count + 1, Acc)
    else
        Length = case Count > 0 of
                     true -> get_length(Count) + 1;
                     false -> 0
                 end,
        compress_helper(T, H, 1, [Length | Acc])
    end.

get_length(Count) ->
    if Count =:= 1 then
        0
    else if Count < 10 then
        1
    else if Count < 100 then
        2
    else
        3
    end.

min(X, Y) ->
    if X < Y then
        X
    else
        Y
    end.

infinity -> 16#7fffffff.

for(Start, End, Fun) ->
    for_helper(Start, End, Fun).

for_helper(Start, End, Fun) when Start > End ->
    ok;
for_helper(Start, End, Fun) ->
    Fun(Start),
    for_helper(Start + 1, End, Fun).