-module(solution).
-export([largest_time/1]).

largest_time(Digits) ->
    DigitsList = lists:permutations(Digits),
    TimeList = [format_time(P) || P <- DigitsList],
    MaxTime = lists:max(TimeList),
    case MaxTime of
        {ok, _} -> format_time_string(MaxTime);
        _ -> ""
    end.

format_time([H1, H2, M1, M2]) ->
    case {H1 * 10 + H2 < 24, M1 * 10 + M2 < 60} of
        {true, true} -> {ok, H1 * 100 + H2 * 10 + M1 * 1 + M2};
        _ -> {error}
    end.

format_time_string({ok, Time}) ->
    H = Time div 100,
    M = Time rem 100,
    lists:flatten(io_lib:format("~2..0B:~2..0B", [H, M]));
format_time_string(_) -> "".