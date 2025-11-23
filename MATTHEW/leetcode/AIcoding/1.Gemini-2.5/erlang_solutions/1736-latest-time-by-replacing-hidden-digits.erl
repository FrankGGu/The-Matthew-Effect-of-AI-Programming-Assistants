-module(solution).
-export([latestTime/1]).

latestTime(S) ->
    [H1, H2, Colon, M1, M2] = S,

    NewH1 = case H1 of
        $? ->
            case H2 of
                $? -> $2; % ?? -> 23
                $0; $1; $2; $3 -> $2; % ?0-?3 -> 20-23
                _ -> $1 % ?4-?9 -> 14-19
            end;
        _ -> H1
    end,

    NewH2 = case H2 of
        $? ->
            case NewH1 of
                $2 -> $3; % 2? -> 23
                _ -> $9 % 0? or 1? -> 09 or 19
            end;
        _ -> H2
    end,

    NewM1 = case M1 of
        $? -> $5; % ?X -> 5X
        _ -> M1
    end,

    NewM2 = case M2 of
        $? -> $9; % X? -> X9
        _ -> M2
    end,

    [NewH1, NewH2, Colon, NewM1, NewM2].