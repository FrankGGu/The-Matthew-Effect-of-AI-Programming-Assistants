-module(peak_finder).
-export([find_peaks/1]).

find_peaks(List) ->
    find_peaks(List, []).

find_peaks([], Acc) ->
    lists:reverse(Acc);
find_peaks([_], Acc) ->
    lists:reverse(Acc);
find_peaks([A,B,C|T], Acc) ->
    case A > B andalso C > B of
        true -> find_peaks([B,C|T], [B | Acc]);
        false -> find_peaks([B,C|T], Acc)
    end.