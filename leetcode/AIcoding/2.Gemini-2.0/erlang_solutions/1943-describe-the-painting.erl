-module(describe_the_painting).
-export([describe_the_painting/1]).

describe_spec(Points) ->
    Segments = lists:sort(
        lists:foldl(
            fun([Start, End, Color], Acc) ->
                [{Start, Color} | [{End, -Color} | Acc]]
            end,
            [],
            Points
        )
    ),

    process_segments(Segments, 0, [], []).

process_segments([], _, AccColors, Result) ->
    lists:reverse(Result);

process_segments([{Point, Color} | Rest], CurrentColor, AccColors, Result) ->
    UpdatedColor = CurrentColor + Color,
    case Rest of
        [] ->
            case UpdatedColor of
                0 ->
                    lists:reverse(Result);
                _ ->
                    lists:reverse([{[Point, 100001], UpdatedColor} | Result])
            end;
        [{NextPoint, _} | _] ->
            case UpdatedColor of
                0 ->
                    process_segments(Rest, UpdatedColor, AccColors, Result);
                _ ->
                    NewResult = [{[Point, NextPoint], UpdatedColor} | Result],
                    process_segments(Rest, UpdatedColor, AccColors, NewResult)
            end
    end.

describe_the_painting(Segments) ->
    FilteredSegments = lists:filter(
        fun([_, _, Color]) ->
            Color > 0
        end,
        describe_spec(Segments)
    ),

    lists:map(
        fun({[Start, End], Color}) ->
            [Start, End, Color]
        end,
        FilteredSegments
    ).