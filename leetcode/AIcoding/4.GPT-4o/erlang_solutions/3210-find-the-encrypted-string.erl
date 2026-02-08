-module(solution).
-export([encrypt/1]).

encrypt(S) ->
    encrypt(S, 0).

encrypt([], _Index) -> 
    "";
encrypt(S, Index) ->
    N = length(S),
    case N rem 2 of
        0 -> 
            {H, T} = lists:split(N div 2),
            lists:append([encrypt(T, Index + 1), lists:sublist(H, 0, 1)]);
        _ -> 
            {H, T} = lists:split(N div 2 + 1),
            lists:append([encrypt(T, Index + 1), lists:sublist(H, 0, 1)])
    end.