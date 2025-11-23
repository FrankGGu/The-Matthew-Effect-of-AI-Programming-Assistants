-module(solution).
-export([number_of_rounds/2]).

number_of_rounds(LoginTime, LogoutTime) ->
    {LoginH, LoginM} = parse_time(LoginTime),
    {LogoutH, LogoutM} = parse_time(LogoutTime),
    LoginTotal = LoginH * 60 + LoginM,
    LogoutTotal = LogoutH * 60 + LogoutM,
    if
        LogoutTotal < LoginTotal ->
            Rounds = calculate_rounds(LoginTotal, 1440) + calculate_rounds(0, LogoutTotal),
            Rounds;
        true ->
            calculate_rounds(LoginTotal, LogoutTotal)
    end.

parse_time(Time) ->
    [H, M] = string:tokens(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.

calculate_rounds(Start, End) ->
    AdjustedStart = case Start rem 15 of
        0 -> Start;
        _ -> Start + (15 - (Start rem 15))
    end,
    AdjustedEnd = End - (End rem 15),
    if
        AdjustedStart >= AdjustedEnd -> 0;
        true -> (AdjustedEnd - AdjustedStart) div 15
    end.