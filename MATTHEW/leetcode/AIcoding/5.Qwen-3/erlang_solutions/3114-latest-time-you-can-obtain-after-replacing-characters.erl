-module(latest_time).
-export([findLatestTime/1]).

findLatestTime(Time) ->
    [C1, C2, $:, C4, C5] = Time,
    A = if C1 == $? -> 2; true -> C1 - $0 end,
    B = if C2 == $? -> 3; true -> C2 - $0 end,
    D = if C4 == $? -> 5; true -> C4 - $0 end,
    E = if C5 == $? -> 9; true -> C5 - $0 end,
    case A of
        2 ->
            if B > 3 -> {error, "Invalid time"};
               true -> ok
            end;
        _ ->
            ok
    end,
    case D of
        5 ->
            if E > 9 -> {error, "Invalid time"};
               true -> ok
            end;
        _ ->
            ok
    end,
    A1 = if C1 == $? -> 2; true -> A end,
    B1 = if C2 == $? -> 3; true -> B end,
    D1 = if C4 == $? -> 5; true -> D end,
    E1 = if C5 == $? -> 9; true -> E end,
    lists:flatten([integer_to_list(A1), integer_to_list(B1), $:, integer_to_list(D1), integer_to_list(E1)]).