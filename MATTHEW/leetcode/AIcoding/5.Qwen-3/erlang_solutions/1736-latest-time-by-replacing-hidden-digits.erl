-module(latest_time_by_replacing_hidden_digits).
-export([maximumTimeFunction/1]).

maximumTimeFunction(Time) ->
    MaximizeTime(Time, 0).

MaximizeTime([], _) ->
    [];
MaximizeTime([C | T], Index) ->
    case C of
        $? ->
            case Index of
                0 -> [$2 | MaximizeTime(T, 1)];
                1 -> [case hd(MaximizeTime(T, 2)) of
                          $? -> $9;
                          _ -> $9
                      end | MaximizeTime(T, 2)];
                2 -> [case hd(MaximizeTime(T, 3)) of
                          $? -> $5;
                          _ -> $5
                      end | MaximizeTime(T, 3)];
                3 -> [case hd(MaximizeTime(T, 4)) of
                          $? -> $9;
                          _ -> $9
                      end | MaximizeTime(T, 4)];
                _ -> [?$9 | MaximizeTime(T, 4)]
            end;
        _ ->
            [C | MaximizeTime(T, Index + 1)]
    end.