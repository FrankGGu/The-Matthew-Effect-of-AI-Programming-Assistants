-module(find_beautiful_indices).
-export([beautifulIndices/3]).

beautifulIndices(S, A, B) ->
    AIndices = findIndices(S, A, []),
    BIndices = findIndices(S, B, []),
    findBeautiful(AIndices, BIndices, 0, []).

findIndices(S, Substring, Acc) ->
    case string:str(S, Substring) of
        0 ->
            lists:reverse(Acc);
        Pos ->
            findIndices(string:substr(S, Pos + 1, length(S)), Substring, [Pos - 1 | Acc])
    end.

findBeautiful([], _, _, Acc) -> lists:reverse(Acc);
findBeautiful([A | RestA], BIndices, K, Acc) ->
    case lists:any(fun(B) -> abs(A - B) =< K end, BIndices) of
        true ->
            findBeautiful(RestA, BIndices, K, [A | Acc]);
        false ->
            findBeautiful(RestA, BIndices, K, Acc)
    end.