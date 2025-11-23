-module(solution).
-export([count_time/1]).

count_time(Time) ->
    [H1, H2, $:, M1, M2] = Time,
    NumHours = solve_part(H1, H2, 23),
    NumMinutes = solve_part(M1, M2, 59),
    NumHours * NumMinutes.

solve_part(Char1, Char2, MaxValue) ->
    D1s = get_possible_digits(Char1),
    D2s = get_possible_digits(Char2),
    lists:foldl(fun(D1, Acc1) ->
                  lists:foldl(fun(D2, Acc2) ->
                                Val = D1 * 10 + D2,
                                if
                                  Val >= 0 andalso Val =< MaxValue -> Acc2 + 1;
                                  true -> Acc2
                                end
                              end, Acc1, D2s)
                end, 0, D1s).

get_possible_digits(Char) ->
    case Char of
        $? -> lists:seq(0, 9);
        _ -> [Char - $0]
    end.