-module(solution).
-export([check_valid_string/1]).

check_valid_string(S) ->
    check_valid_string_impl(S, 0, 0).

check_valid_string_impl([], LowCount, _HighCount) ->
    LowCount == 0;
check_valid_string_impl([Char|Rest], LowCount, HighCount) ->
    {UpdatedLow, UpdatedHigh} =
        case Char of
            $( ->
                {LowCount + 1, HighCount + 1};
            $) ->
                {max(0, LowCount - 1), HighCount - 1};
            $* ->
                {max(0, LowCount - 1), HighCount + 1}
        end,

    if
        UpdatedHigh < 0 ->
            false;
        true ->
            check_valid_string_impl(Rest, UpdatedLow, UpdatedHigh)
    end.