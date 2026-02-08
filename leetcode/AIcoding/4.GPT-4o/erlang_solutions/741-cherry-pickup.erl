-module(solution).
-export([cherryPickup/1]).

cherryPickup(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    DP = array:new({N, M, M}, default),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            array:write(DP, {I, J, J}, -1) 
        end, lists:seq(0, M-1))
    end, lists:seq(0, N-1)),
    pickup(Grid, DP, 0, 0, 0).

pickup(Grid, DP, R1, C1, C2) ->
    N = length(Grid),
    M = length(hd(Grid)),
    case (R1 >= N orelse C1 >= M orelse C2 >= M orelse C1 < 0 orelse C2 < 0) of
        true -> 0;
        false ->
            case array:read(DP, {R1, C1, C2}) of
                -1 ->
                    Cherries = if 
                        lists:nth(C1 + 1, lists:nth(R1 + 1, Grid)) =:= 1 -> 1; 
                        true -> 0 
                    end + if 
                        C1 =:= C2 -> 0; 
                        true -> if 
                            lists:nth(C2 + 1, lists:nth(R1 + 1, Grid)) =:= 1 -> 1; 
                            true -> 0 
                        end 
                    end,
                    Result = Cherries + max(max(pickup(Grid, DP, R1 + 1, C1, C2), 
                                                 pickup(Grid, DP, R1, C1 + 1, C2)), 
                                             max(pickup(Grid, DP, R1 + 1, C1, C2 + 1), 
                                                 pickup(Grid, DP, R1, C1 + 1, C2 + 1))),
                    array:write(DP, {R1, C1, C2}, Result),
                    Result;
                Val -> Val
            end
    end.