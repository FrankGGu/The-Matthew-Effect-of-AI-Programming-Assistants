-module(substring_xor_queries).
-export([substring_xor/2]).

substring_xor(S, Qs) ->
    N = length(S),
    Map = maps:from_list([{X, I} || {I, X} <- lists:zip(lists:seq(0, N-1), S)]),
    Results = [find_substring(S, Q, Map) || Q <- Qs],
    Results.

find_substring(S, {A, B}, Map) ->
    AChar = maps:get(A, Map),
    BChar = maps:get(B, Map),
    find_substring_helper(S, A, B, AChar, BChar, 0).

find_substring_helper(S, A, B, AChar, BChar, Pos) when Pos > B ->
    -1;
find_substring_helper(S, A, B, AChar, BChar, Pos) ->
    CurrentChar = lists:nth(Pos + 1, S),
    if
        CurrentChar == AChar andalso (Pos + 1) <= B ->
            case check_xor(S, Pos, B, AChar, BChar) of
                true -> Pos;
                false -> find_substring_helper(S, A, B, AChar, BChar, Pos + 1)
            end;
        true ->
            find_substring_helper(S, A, B, AChar, BChar, Pos + 1)
    end.

check_xor(S, Start, End, AChar, BChar) ->
    Length = End - Start + 1,
    XOR = lists:foldl(fun(I, Acc) ->
                          Acc bxor (lists:nth(I + 1, S) - $0)
                      end, 0, lists:seq(Start, End)),
    XOR == (AChar - $0) bxor (BChar - $0).