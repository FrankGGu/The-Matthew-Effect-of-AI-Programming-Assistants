-module(solution).
-export([rotate/2]).

rotate(Nums, K) ->
    N = length(Nums),
    case N of
        0 ->
            [];
        _ ->
            K_eff = K rem N,
            case K_eff of
                0 ->
                    Nums;
                _ ->
                    {FirstPart, LastPart} = lists:split(N - K_eff, Nums),
                    LastPart ++ FirstPart
            end
    end.