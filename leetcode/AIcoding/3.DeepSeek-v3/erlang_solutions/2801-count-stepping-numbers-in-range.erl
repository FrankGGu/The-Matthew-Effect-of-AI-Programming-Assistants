-module(solution).
-export([count_stepping_numbers/2]).

count_stepping_numbers(Low, High) ->
    Start = integer_to_list(Low),
    End = integer_to_list(High),
    CountLow = count_stepping_numbers_helper(Start),
    CountHigh = count_stepping_numbers_helper(End),
    IsLowStepping = is_stepping(Start),
    CountHigh - CountLow + (if IsLowStepping -> 1; true -> 0 end).

count_stepping_numbers_helper(Str) ->
    Length = length(Str),
    DP = init_dp(Length),
    count(Str, DP, Length, 0, 0, true, false).

init_dp(Length) ->
    maps:from_list([{{Pos, Prev, LeadingZero, Tight}, -1} ||
        Pos <- lists:seq(0, Length),
        Prev <- lists:seq(0, 9),
        LeadingZero <- [true, false],
        Tight <- [true, false]]).

count(Str, DP, Length, Pos, Prev, LeadingZero, Tight) ->
    Key = {Pos, Prev, LeadingZero, Tight},
    case maps:get(Key, DP, -1) of
        -1 ->
            Res = if
                Pos =:= Length ->
                    if LeadingZero -> 0; true -> 1 end;
                true ->
                    Limit = if Tight -> lists:nth(Pos + 1, Str) - $0; true -> 9 end,
                    lists:foldl(fun(D, Acc) ->
                        NextTight = Tight and (D =:= Limit),
                        NextLeadingZero = LeadingZero and (D =:= 0),
                        if
                            LeadingZero ->
                                Acc + count(Str, DP, Length, Pos + 1, D, NextLeadingZero, NextTight);
                            abs(D - Prev) =:= 1 ->
                                Acc + count(Str, DP, Length, Pos + 1, D, NextLeadingZero, NextTight);
                            true ->
                                Acc
                        end
                    end, 0, lists:seq(0, Limit))
            end,
            maps:put(Key, Res, DP),
            Res;
        Cached ->
            Cached
    end.

is_stepping(Str) ->
    lists:all(fun({A, B}) -> abs(A - B) =:= 1 end,
              lists:zip(lists:map(fun(C) -> C - $0 end, Str),
                          tl(lists:map(fun(C) -> C - $0 end, Str)))).