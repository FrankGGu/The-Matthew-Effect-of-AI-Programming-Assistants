-module(solution).
-export([balanced_string_split/1]).

balanced_string_split(S) ->
    balanced_string_split(S, 0, 0).

balanced_string_split([], Count, Acc) ->
    Acc + (if Count =:= 0 -> 1; true -> 0 end);
balanced_string_split([H | T], Count, Acc) ->
    NewCount = case H of
        $R -> Count + 1;
        $L -> Count - 1
    end,
    balanced_string_split(T, NewCount, Acc + (if NewCount =:= 0 -> 1; true -> 0 end)).