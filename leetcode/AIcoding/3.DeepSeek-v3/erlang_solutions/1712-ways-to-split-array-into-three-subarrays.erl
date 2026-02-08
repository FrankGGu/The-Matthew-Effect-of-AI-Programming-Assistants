-module(solution).
-export([ways_to_split/1]).

ways_to_split(Nums) ->
    Prefix = prefix_sum(Nums),
    Total = lists:last(Prefix),
    N = length(Nums),
    Mod = 1000000007,
    ways_to_split(Prefix, Total, N, Mod, 0, 1, 1).

prefix_sum(Nums) ->
    lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(Nums)).

ways_to_split(Prefix, Total, N, Mod, Res, J, K) when J =< N ->
    Left = lists:nth(J + 1, Prefix),
    case Left * 3 > Total of
        true -> Res rem Mod;
        false ->
            NewJ = find_j(Prefix, J, N, Left),
            case NewJ > N of
                true -> Res rem Mod;
                false ->
                    Right = Total - Left,
                    case Right < Left of
                        true -> Res rem Mod;
                        false ->
                            NewK = find_k(Prefix, max(K, NewJ), N, Left, Right),
                            case NewK >= NewJ of
                                true -> ways_to_split(Prefix, Total, N, Mod, (Res + NewK - NewJ + 1) rem Mod, NewJ + 1, NewK + 1);
                                false -> ways_to_split(Prefix, Total, N, Mod, Res rem Mod, NewJ + 1, NewK + 1)
                            end
                    end
            end
    end;
ways_to_split(_Prefix, _Total, _N, _Mod, Res, _J, _K) ->
    Res rem Mod.

find_j(Prefix, J, N, Left) ->
    case J =< N andalso lists:nth(J + 1, Prefix) < Left * 2 of
        true -> find_j(Prefix, J + 1, N, Left);
        false -> J
    end.

find_k(Prefix, K, N, Left, Right) ->
    case K =< N andalso (Total - lists:nth(K + 1, Prefix)) >= Left of
        true -> find_k(Prefix, K + 1, N, Left, Right);
        false -> K - 1
    end.