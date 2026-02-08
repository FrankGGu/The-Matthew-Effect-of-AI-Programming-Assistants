-module(solution).
-export([check_if_segments_are_longer/1]).

check_if_segments_are_longer(S) ->
    {OnesSegments, ZerosSegments} = count_segments(S, 0, 0, nil),
    OnesSegments > ZerosSegments.

count_segments([], Ones, Zeros, _PrevChar) ->
    {Ones, Zeros};
count_segments([Char|Rest], Ones, Zeros, PrevChar) ->
    case Char of
        $1 ->
            case PrevChar of
                $1 ->
                    count_segments(Rest, Ones, Zeros, $1);
                _ ->
                    count_segments(Rest, Ones + 1, Zeros, $1)
            end;
        $0 ->
            case PrevChar of
                $0 ->
                    count_segments(Rest, Ones, Zeros, $0);
                _ ->
                    count_segments(Rest, Ones, Zeros + 1, $0)
            end
    end.