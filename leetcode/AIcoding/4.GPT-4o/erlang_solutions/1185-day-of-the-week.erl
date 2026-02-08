-module(solution).
-export([day_of_week/3]).

day_of_week(Y, M, D) ->
    %% Zeller's Congruence Algorithm
    If M < 3 -> 
        M1 = M + 12, 
        Y1 = Y - 1 
    else 
        M1 = M, 
        Y1 = Y 
    end,
    K = Y1 rem 100,
    J = Y1 div 100,
    F = D + (13 * (M1 + 1)) div 5 + K + K div 4 + J div 4 - 2 * J,
    Days = F rem 7,
    case Days of
        0 -> "Saturday";
        1 -> "Sunday";
        2 -> "Monday";
        3 -> "Tuesday";
        4 -> "Wednesday";
        5 -> "Thursday";
        6 -> "Friday"
    end.