-module(full_rounds).
-export([number_of_full_rounds/2]).

number_of_full_rounds(StartTime, FinishTime) ->
    {Sh, Sm} = parse_time(StartTime),
    {Fh, Fm} = parse_time(FinishTime),
    StartMinutes = Sh * 60 + Sm,
    FinishMinutes = Fh * 60 + Fm,

    case StartMinutes > FinishMinutes of
        true ->
            TotalMinutes = 24 * 60;
            StartAligned = (StartMinutes + (60 - (StartMinutes rem 15))) rem 60;
            FinishAligned = FinishMinutes - (FinishMinutes rem 15);

            case StartAligned == 60 of
                true -> StartAlignedMinutes = 0;
                false -> StartAlignedMinutes = StartAligned
            end,

            case FinishAligned < 0 of
                true -> FinishAlignedMinutes = 24 * 60 + FinishAligned;
                false -> FinishAlignedMinutes = FinishAligned
            end,

            FullRounds = (FinishAlignedMinutes + (TotalMinutes - StartMinutes - (StartAlignedMinutes - StartMinutes))) div 15;
            FullRounds;
        false ->
            StartAligned = (StartMinutes + (60 - (StartMinutes rem 15))) rem 60;
            FinishAligned = FinishMinutes - (FinishMinutes rem 15);

            case StartAligned == 60 of
                true -> StartAlignedMinutes = 0;
                false -> StartAlignedMinutes = StartAligned
            end,

            FullRounds = (FinishAligned - StartAlignedMinutes) div 15;

            case FullRounds < 0 of
                true -> 0;
                false -> FullRounds
            end
    end.

parse_time(Time) ->
    [H, M] = string:split(Time, ":", all),
    {list_to_integer(H), list_to_integer(M)}.